import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/isar.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef UrlConfigNotifier
    = AutoDisposeNotifierProvider<UrlConfigProvider, void>;

final urlConfigProvider = UrlConfigNotifier(UrlConfigProvider.new);

class UrlConfigProvider extends AutoDisposeNotifier {
  late AppSettings _currSettings;
  late final TextEditingController urlCntrlr;
  late List<String> _urls;
  late List<String> _urlHeaders;
  late int _currUrlIndex;

  @override
  build() {
    ref.watch(settingsStreamProvider);
    _currSettings = appSettings;
    _urls = [globalBaseUrl, devBaseUrl, localBaseUrl];
    _urlHeaders = ['Global', 'Dev', 'Local'];
    _currUrlIndex = _urls.indexOf(_currSettings.baseUrl);
    urlCntrlr = TextEditingController(text: _currSettings.baseUrl);
  }

  AppSettings get currSettings => _currSettings;

  List<String> get urls => _urls;

  List<String> get urlHeaders => _urlHeaders;

  int get currUrlIndex => _currUrlIndex;

  void toggleSecureProtocol(bool? v) {
    if (v == null) return;
    _currSettings.useSecureProtocol = v;
    ref.notifyListeners();
  }

  void toggleUrl(int? i) {
    if (i == null) return;
    _currSettings.baseUrl = _urls[i];
    urlCntrlr.text = _urls[i];
    _currUrlIndex = i;
    ref.notifyListeners();
  }

  Future<void> submit() async {
    appSettings = _currSettings;
    await appSettings.save();
  }
}
