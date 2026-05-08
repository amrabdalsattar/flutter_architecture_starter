import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

import '../../../networking/result_or_failure.dart';
import '../../custom_loading_widget.dart';
import '../api_cubit.dart';
import 'pagination_model.dart';

abstract class PaginationCubit<T extends Equatable, L extends PaginationModel>
    extends ApiCubit<List<T>> {
  final Future<ResultOrFailure<List<T>>> Function(L requestModel) repoMethod;
  PaginationCubit(this.repoMethod);

  final _debouncer = Debouncer();
  final List<T> items = [];
  L? prevRequestModel;
  Future<void> getItems(
    L Function(int page) requestModelMethod, {
    bool isRefresh = false,
    bool isIncremental = true,
  }) async {
    if (prevRequestModel != null) {
      if (prevRequestModel != requestModelMethod(page)) {
        items.clear();
        page = 0;
      }
    }

    if (!hasMore && items.isNotEmpty) return;

    if (items.isEmpty) emit(ApiLoadingState());
    final requestModel = requestModelMethod(page);

    _debouncer.debounce(
      duration: const Duration(milliseconds: 500),
      onDebounce: () async {
        final result = await repoMethod(requestModel);

        switch (result) {
          case SuccessResult():
            isRefresh ? items.clear() : null;
            items.addAll(
              result.data.where((element) => !items.contains(element)),
            );
            emit(ApiSuccessState(items));
            if (!isRefresh) {
              if (isIncremental) incrementPage();
              setHasMore(result.data.length == requestModel.pageSize);
              prevRequestModel = requestModel;
            }

          case FailureResult():
            emit(ApiFailureState(result.errorMessage));
        }
      },
    );
  }

  void removeWhere(bool Function(T) test) {
    items.removeWhere(test);
    emit(ApiSuccessState(items));
  }

  void reset() {
    items.clear();
    page = 0;
    hasMore = true;
    emit(ApiSuccessState(items));
  }

  int page = 0;
  bool hasMore = true;

  void incrementPage() => page++;

  void setHasMore(bool value) => hasMore = value;

  bool shouldRequestNextPage(
    int index,
    L Function(int page) requestModelBuilder,
  ) => hasMore && index == page * requestModelBuilder(page).pageSize;

  @override
  Future<void> close() async {
    _debouncer.cancel();
    super.close();
  }
}

// Pagination ListView.builder
class PaginationListViewBuilder<
  T extends PaginationCubit<L, M>,
  L extends Equatable,
  M extends PaginationModel
>
    extends StatelessWidget {
  final Widget Function(List<L> items, int index) paginationItemBuilder;
  final M Function(int page) requestModelBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Widget? emptySliverWidget;
  final Widget? loadingWidget;
  final bool? shrinkWrap;
  final int? itemCount;
  final bool hasErrorRetry;
  final Widget? failureWidget;
  const PaginationListViewBuilder({
    super.key,
    required this.paginationItemBuilder,
    required this.requestModelBuilder,
    this.padding,
    this.physics,
    this.emptySliverWidget,
    this.loadingWidget,
    this.shrinkWrap,
    this.itemCount,
    this.hasErrorRetry = true,
    this.failureWidget,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<T>();
    return ApiBlocBuilder<T, List<L>>(
      request: (cubit) {
        if (!_isTopOfNavigationStack(context)) return;
        cubit.getItems(requestModelBuilder);
      },
      loadingWidget: (_) => loadingWidget ?? const CustomLoadingWidget(),
      hasRetry: hasErrorRetry,
      failureWidget: failureWidget,
      successWidget: (items) {
        if (items.isEmpty && emptySliverWidget == null) {
          return const SizedBox.shrink();
        }

        return CustomScrollView(
          physics: physics ?? const BouncingScrollPhysics(),
          shrinkWrap: shrinkWrap ?? false,
          slivers: [
            if (items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: emptySliverWidget),
              ),

            if (items.isNotEmpty)
              SliverList.builder(
                itemCount: itemCount ?? items.length + 1,
                itemBuilder: (context, index) {
                  if (cubit.shouldRequestNextPage(index, requestModelBuilder)) {
                    if (!_isTopOfNavigationStack(context)) {
                      return const SizedBox.shrink();
                    }
                    cubit.getItems(requestModelBuilder);
                    return loadingWidget ?? const CustomLoadingWidget();
                  }

                  if (index > items.length - 1) return const SizedBox.shrink();

                  return paginationItemBuilder(items, index);
                },
              ),
          ],
        );
      },
    );
  }

  bool _isTopOfNavigationStack(BuildContext context) {
    final route = ModalRoute.of(context);
    return route?.isCurrent ?? false;
  }
}
