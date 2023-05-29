part of '../extensions.dart';

extension DoubleExt on double {
  String get formatted => NumberFormat.currency(
        customPattern: currency.numberPattern,
        symbol: currency.symbol,
        decimalDigits: 0,
      ).format(this);

  String get formattedFloat => NumberFormat.currency(
        customPattern: currency.numberPattern,
        symbol: currency.symbol,
        decimalDigits: 2,
      ).format(this);

  String get formattedCompat => NumberFormat.compactCurrency(
        symbol: currency.symbol,
        decimalDigits: 0,
      ).format(this);

  /// 3 digits
  double get toPrecise => double.parse(toStringAsFixed(3));
}

extension ListDoubleExt on List<double> {
  double get sum => fold(0, (p, c) => p + c);
  double get average => sum / length;
  double get max => fold(0, (p, c) => p > c ? p : c);
}

extension IterableDoubleExt on Iterable<double> {
  double get sum => fold(0, (p, c) => p + c);
  double get average => sum / length;
  double get max => fold(0, (p, c) => p > c ? p : c);
}
