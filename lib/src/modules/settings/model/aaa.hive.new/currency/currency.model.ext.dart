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

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        _JSON.name: name,
        _JSON.symbol: symbol,
        _JSON.shortForm: shortForm,
      };
}
