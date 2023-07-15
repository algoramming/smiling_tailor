part of 'measurement.dart';

extension MeasurementTrxExt on Measurement {
  Future<void> saveData() async => await Boxes.measurement.put(id, this);

  Future<void> deleteData() async => await Boxes.measurement.delete(id);
}

extension ListMeasurementTrxExt on List<Measurement> {
  Future<void> saveAllData() async => await Boxes.measurement
      .putAll(Map.fromEntries(map((e) => MapEntry(e.id, e))));

  Future<void> deleteAllData() async =>
      await Boxes.measurement.deleteAll(map((e) => e.id).toList());
}

extension MeasurementStringExt on String {
  Measurement? get getMeasurement {
    return appMeasurements.any((e) => e.name == this)
        ? appMeasurements.firstWhere((e) => e.name == this)
        : null;
  }
}
