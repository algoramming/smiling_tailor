part of 'currency.model.dart';

const bdtNumberFormat = '৳#,##,##0.00#';
const usdNumberFormat = '\$#,##0.00';

extension CurrencyTrxExt on CurrencyProfile {
  String? get numberPattern => shortForm == 'BDT' ? bdtNumberFormat : null;

  int saveSync({bool silent = false}) =>
      db.writeTxnSync(() => db.currencyProfiles.putSync(this), silent: silent);

  Future<int> save({bool silent = false}) async => await db
      .writeTxn(() async => await db.currencyProfiles.put(this), silent: silent);
}

extension ListCurrencyTrxExt on List<CurrencyProfile> {
  List<int> saveAllSync({bool silent = false}) =>
      db.writeTxnSync(() => db.currencyProfiles.putAllSync(this), silent: silent);

  Future<List<int>> saveAll({bool silent = false}) async => await db
      .writeTxn(() async => await db.currencyProfiles.putAll(this), silent: silent);
}
