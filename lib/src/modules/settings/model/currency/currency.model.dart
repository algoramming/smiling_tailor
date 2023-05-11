import 'dart:convert';

part 'currency.model.ext.dart';

class CurrencyProfile {
  CurrencyProfile({
    required this.name,
    required this.symbol,
    required this.shortForm,
  });

  String name;
  String symbol;
  String shortForm;

  factory CurrencyProfile.fromRawJson(String str) =>
      CurrencyProfile.fromJson(json.decode(str));

  factory CurrencyProfile.fromJson(Map<String, dynamic> json) =>
      CurrencyProfile(
        name: json[_JSON.name] as String,
        symbol: json[_JSON.symbol] as String,
        shortForm: json[_JSON.shortForm] as String,
      );
}

class _JSON {
  static const String name = 'name';
  static const String symbol = 'symbol';
  static const String shortForm = 'short_form';
}
