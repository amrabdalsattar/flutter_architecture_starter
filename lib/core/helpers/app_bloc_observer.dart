import 'package:flutter_bloc/flutter_bloc.dart';

import 'log_helper.dart';

class AppBlocObserver extends BlocObserver {
  final _blocs = <BlocBase>{};

  @override
  void onCreate(BlocBase bloc) {
    _blocs.add(bloc);
    super.onCreate(bloc);
    LogHelper.logWarning('''
┌─ onCreate ────────────────────────────
│  bloc  : ${bloc._label}
│  active: ${_blocs._summary}
│  count : ${_blocs.length}
└───────────────────────────────────────''');
  }

  @override
  void onClose(BlocBase bloc) {
    _blocs.remove(bloc);
    super.onClose(bloc);
    LogHelper.logWarning('''
┌─ onClose ─────────────────────────────
│  bloc  : ${bloc._label}
│  active: ${_blocs._summary}
│  count : ${_blocs.length}
└───────────────────────────────────────''');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    LogHelper.logError('''
┌─ onError ─────────────────────────────
│  bloc  : ${bloc._label}
│  error : $error
│  active: ${_blocs._summary}
│  count : ${_blocs.length}
└───────────────────────────────────────''');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    LogHelper.logWarning('''
┌─ onChange ─────────────────────────────
│  bloc : ${bloc._label}
│  prev : ${change.currentState.runtimeType}
│  next : ${change.nextState.runtimeType}
└────────────────────────────────────────''');
  }
}

extension _BlocBaseExtension on BlocBase {
  String get _label => '$runtimeType #${hashCode.toRadixString(16)}';
}

extension _BlocSetExtension on Iterable<BlocBase> {
  String get _summary {
    if (isEmpty) return '(none)';
    return map((b) => b.runtimeType.toString()).join(', ');
  }
}
