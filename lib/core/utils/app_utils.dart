import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../helpers/app_bloc_observer.dart';
import '../networking/api_error_handler.dart';
import '../networking/result_or_failure.dart';
import 'package:intl/intl.dart';

String numbersFormat(num price) {
  if (price >= 1000) {
    return NumberFormat('#,##0.#').format((price));
  } else {
    return NumberFormat('###.#').format((price));
  }
}

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

void setBlocObserver() => Bloc.observer = AppBlocObserver();

Future<ResultOrFailure<T>> tryCatchBlock<T>(
  Future<T> Function() function, {
  Function()? onError,
}) async {
  if (!(await InternetConnectionChecker.createInstance().hasConnection)) {
    return FailureResult(ErrorHandler.handle('No Internet Connection'));
  }

  try {
    final result = await function();
    return SuccessResult(result);
  } catch (error) {
    // _monitorError(error);
    if (onError != null) onError();
    return FailureResult(ErrorHandler.handle(error));
  }
}
