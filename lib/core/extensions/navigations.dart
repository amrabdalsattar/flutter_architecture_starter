
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

extension Navigation on BuildContext {
  Future<void> push({
    void Function(Object? result)? toExecuteAfterPop,
    required Widget widget,
    PageTransitionType type = PageTransitionType.fade,
  }) async {
    return Navigator.push(this, PageTransition(child: widget, type: type)).then(
      (value) {
        if (toExecuteAfterPop != null) toExecuteAfterPop(value);
      },
    );
  }

  void pushReplacementRightToLeftJoined({
    required Widget currentScreen,
    required Widget nextScreen,
  }) {
    Navigator.push(
      this,
      PageTransition(
        type: PageTransitionType.rightToLeftJoined,
        duration: const Duration(milliseconds: 500),
        childCurrent: currentScreen,
        child: nextScreen,
      ),
    );
  }

  void pushAndRemoveUntil({
    required Widget widget,
    PageTransitionType type = PageTransitionType.fade,
    bool Function(Route<dynamic>)? predicate,
  }) {
    Navigator.pushAndRemoveUntil(
      this,
      PageTransition(child: widget, type: type),
      predicate ?? (route) => false,
    );
  }

  void pushReplacement({
    required Widget widget,
    PageTransitionType type = PageTransitionType.fade,
    int transitionDurationInMillieSeconds = 200,
  }) {
    Navigator.pushReplacement(
      this,
      PageTransition(
        child: widget,
        type: type,
        duration: Duration(milliseconds: transitionDurationInMillieSeconds),
      ),
    );
  }

  void pop({Object? result}) {
    if (Navigator.canPop(this)) Navigator.pop(this, result);
  }

  bool canPop() => Navigator.canPop(this);
}
