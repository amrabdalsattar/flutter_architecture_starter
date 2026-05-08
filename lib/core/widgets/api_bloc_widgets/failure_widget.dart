import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../helpers/localization/locale_keys.dart';
import '../../theming/app_colors.dart';
import '../../theming/app_text_styles.dart';
import '../../extensions/navigations.dart';
import 'api_cubit.dart';

class FailureWidget<T extends Cubit<ApiState>> extends StatefulWidget {
  const FailureWidget({
    super.key,
    required this.failureWidget,
    required this.request,
  });

  final Widget failureWidget;
  final void Function(T)? request;

  @override
  State<FailureWidget<T>> createState() => FailureWidgetState<T>();
}

class FailureWidgetState<T extends Cubit<ApiState>>
    extends State<FailureWidget<T>> {
  StreamSubscription<InternetConnectionStatus>? _streamSubscription;

  // initial status is connected to avoid infinite loop of request on failure
  InternetConnectionStatus _lastStatus = InternetConnectionStatus.connected;
  @override
  void initState() {
    super.initState();
    _streamSubscription = InternetConnectionChecker.createInstance()
        .onStatusChange
        .listen((status) {
          if (!mounted) {
            _streamSubscription?.cancel();
            return;
          }

          if (_lastStatus == InternetConnectionStatus.disconnected &&
              status == InternetConnectionStatus.connected) {
            if (widget.request != null) {
              widget.request!(BlocProvider.of<T>(context));
            }
          }
          _lastStatus = status;
        });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.failureWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (widget.request != null) {
                    widget.request!(BlocProvider.of<T>(context));
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.black, width: 1),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
                child: Text(
                  LocaleKeys.common.retry,
                  style: AppTextStyles.font16MediumBlack,
                ),
              ),
              if (context.canPop()) const SizedBox(width: 16),
              if (context.canPop())
                ElevatedButton(
                  onPressed: () => context.pop(),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.black, width: 1),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.common.goBack,
                    style: AppTextStyles.font16MediumBlack,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
