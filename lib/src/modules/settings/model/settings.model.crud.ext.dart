part of 'settings.model.dart';

extension AppSettingsDBExt on AppSettings {
  // Future<void> save([bool isSilent = false]) async => await db
  //     .writeTxn(() async => await db.appSettings.put(this), silent: isSilent);

  // Future<void> delete() async => await db.writeTxn(() async => await db.appSettings.delete(id));

  Future<void> saveData() async => await Boxes.appSettings.put(appName.toCamelWord, this);
}
