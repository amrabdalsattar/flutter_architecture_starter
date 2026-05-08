

extension IntExtension<T> on String {
  bool get isInt => int.tryParse(this) != null;
}

extension ToFixed on double {
  double toFixed(int fractionDigits) =>
      double.parse(toStringAsFixed(fractionDigits));
}


extension ToIntString on num {
  String toIntStringIfPossible() {
    if (this == toInt()) return toInt().toString();

    return toString();
  }
}

