part of 'currency.model.dart';

extension CurrencyProfileExtension on CurrencyProfile {
  CurrencyProfile copyWith({
    String? name,
    String? symbol,
    String? shortForm,
  }) =>
      CurrencyProfile()
        ..name = name ?? this.name
        ..symbol = symbol ?? this.symbol
        ..shortForm = shortForm ?? this.shortForm;
}
