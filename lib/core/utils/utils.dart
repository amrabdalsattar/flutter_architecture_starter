import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/app_bloc_observer.dart';

abstract class Utils {
  static void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

  static void setBlocObserver() => Bloc.observer = AppBlocObserver();
}
