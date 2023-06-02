part of 'measurement.dart';

extension MeasurementTrxExt on Measurement {
  int saveSync({bool silent = false}) =>
      db.writeTxnSync(() => db.measurements.putSync(this), silent: silent);

  Future<int> save({bool silent = false}) async => await db
      .writeTxn(() async => await db.measurements.put(this), silent: silent);

  bool deleteSync({bool silent = false}) =>
      db.writeTxnSync(() => db.measurements.deleteSync(id!), silent: silent);

  Future<bool> delete({bool silent = false}) async => await db
      .writeTxn(() async => await db.measurements.delete(id!), silent: silent);
}

extension ListMeasurementTrxExt on List<Measurement> {
  List<int> saveAllSync({bool silent = false}) =>
      db.writeTxnSync(() => db.measurements.putAllSync(this), silent: silent);

  Future<List<int>> saveAll({bool silent = false}) async => await db
      .writeTxn(() async => await db.measurements.putAll(this), silent: silent);

  int deleteAllSync({bool silent = false}) => db.writeTxnSync(
      () => db.measurements.deleteAllSync(map((e) => e.id!).toList()),
      silent: silent);

  Future<int> deleteAll({bool silent = false}) async => await db.writeTxn(
      () async => await db.measurements.deleteAll(map((e) => e.id!).toList()),
      silent: silent);
}

extension MeasurementStringExt on String {
  Future<Measurement?> getMeasurement() async =>
      await db.measurements.where().filter().nameEqualTo(this).findFirst();
}
