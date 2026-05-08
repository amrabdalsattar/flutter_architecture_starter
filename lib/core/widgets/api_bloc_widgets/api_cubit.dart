import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/log_helper.dart';
import '../../networking/result_or_failure.dart';
import '../../theming/app_colors.dart';
import '../../theming/app_sizer.dart';
import '../../utils/extensions.dart';
import '../app_skeletonizer.dart';
import '../exception_widget.dart';
import 'failure_widget.dart';

part 'api_states.dart';

// Cubit
abstract class ApiCubit<T> extends Cubit<ApiState<T>> {
  ApiCubit() : super(ApiInitialState());

  @override
  void emit(ApiState<T> state) {
    if (isClosed) {
      return LogHelper.logWarning('Tried to emit state $state on closed cubit');
    }

    super.emit(state);
  }

  Future<void> executeApiCall(
    Future<ResultOrFailure<T>> Function() repoFunction,
  ) async {
    emit(ApiLoadingState());
    final result = await repoFunction();
    switch (result) {
      case SuccessResult<T>():
        emit(ApiSuccessState<T>(result.data));
      case FailureResult():
        emit(ApiFailureState(result.errorMessage));
    }
  }
}

// BlocBuilder
class ApiBlocBuilder<T extends Cubit<ApiState<L>>, L> extends StatefulWidget {
  final Widget Function(T cubit)? loadingWidget;
  final Widget Function(L data) successWidget;
  final Widget? failureWidget;
  final void Function(T cubit)? request;
  final L? shimmerData;
  final bool Function(ApiState<dynamic> previous, ApiState<dynamic> current)?
  buildWhen;
  final bool hasRetry;

  const ApiBlocBuilder({
    super.key,
    this.loadingWidget,
    required this.successWidget,
    this.request,
    this.failureWidget,
    this.buildWhen,
    this.shimmerData,
    this.hasRetry = true,
  });

  @override
  State<ApiBlocBuilder<T, L>> createState() => _ApiBlocBuilderState<T, L>();
}

class _ApiBlocBuilderState<T extends Cubit<ApiState<L>>, L>
    extends State<ApiBlocBuilder<T, L>> {
  @override
  void initState() {
    if (widget.request != null) widget.request!(BlocProvider.of<T>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, ApiState<L>>(
      buildWhen: widget.buildWhen,
      builder: (context, state) {
        switch (state) {
          case ApiInitialState<L>():
          case ApiLoadingState<L>():
            if (widget.shimmerData != null) {
              return AppSkeletonizer(
                // IgnorePointer to avoid triggering any onTap or gestures on the successWidget
                child: IgnorePointer(
                  child: widget.successWidget(widget.shimmerData as L),
                ),
              );
            }
            if (widget.loadingWidget == null) {
              return Center(
                child: SizedBox(
                  width: 45.w,
                  height: 45.w,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 3.w,
                  ),
                ),
              );
            }
            return widget.loadingWidget!(BlocProvider.of<T>(context));

          case ApiFailureState<L>():
            return widget.hasRetry
                ? FailureWidget(
                  failureWidget:
                      widget.failureWidget ??
                      ExceptionWidget(text: state.errorMessage),
                  request: widget.request,
                )
                : widget.failureWidget ?? const SizedBox.shrink();

          case ApiSuccessState<L>():
            return widget.successWidget(state.data);
        }
      },
    );
  }
}

// BlocListener
class ApiBlocListener<T extends Cubit<ApiState<L>>, L> extends StatelessWidget {
  final T? bloc;
  final Function(BuildContext context)? executeWhenLoading;
  final Function(BuildContext context, ApiFailureState<L> state)?
  executeWhenFailure;
  final Function(BuildContext context, L data) executeWhenSuccess;
  final Widget? child;

  const ApiBlocListener({
    super.key,
    this.bloc,
    this.executeWhenLoading,
    this.executeWhenFailure,
    required this.executeWhenSuccess,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, ApiState<L>>(
      listenWhen: (previous, current) {
        if (previous is ApiLoadingState && current is ApiLoadingState) {
          return false;
        }

        return true;
      },
      listener: (context, state) {
        switch (state) {
          case ApiLoadingState<L>():
            executeWhenLoading ??
                context.showProgressiveLoadingDialog(context.read<T>());

          case ApiFailureState<L>():
            if (executeWhenFailure != null) {
              executeWhenFailure!(context, state);
            } else {
              // Not all failures require a pop
              context.pop();
              context.showErrorSnackBar(content: state.errorMessage);
            }

          case ApiSuccessState<L>():
            executeWhenSuccess(context, state.data);

          default:
            context.pop();
        }
      },
      child: child,
    );
  }
}
