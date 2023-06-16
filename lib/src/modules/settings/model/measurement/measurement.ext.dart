part of 'measurement.dart';

extension MeasurementTrxExt on Measurement {
  Future<void> save() async => await Boxes.measurement.put(id, this);

  Future<void> delete() async => await Boxes.measurement.delete(id);
}

extension ListMeasurementTrxExt on List<Measurement> {
  Future<void> saveAll() async => await Boxes.measurement
      .putAll(Map.fromEntries(map((e) => MapEntry(e.id, e))));

  Future<void> deleteAll() async =>
      await Boxes.measurement.deleteAll(map((e) => e.id).toList());
}

extension MeasurementStringExt on String {
  Measurement? get getMeasurement {
    return appMeasurements.any((e) => e.name == this)
        ? appMeasurements.firstWhere((e) => e.name == this)
        : null;
  }
}
