import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/paths.dart';
import '../../order/add/pdf/file.handle.dart';
import '../function/load.files.dart';

typedef InvoiceNotifier
    = AutoDisposeAsyncNotifierProvider<InvoiceProvider, List<File>>;

final invoiceProvider = InvoiceNotifier(InvoiceProvider.new);

final filesStream =
    StreamProvider((_) => Directory(appDir.invoice.path).list());

class InvoiceProvider extends AutoDisposeAsyncNotifier<List<File>> {
  final searchCntrlr = TextEditingController();
  late List<File> _files;
  late List<String> _selectedFilePaths;
  bool _isSelectingMode = false;

  @override
  FutureOr<List<File>> build() async {
    _listener();
    _files = await loadFilesFromDirectory();
    _selectedFilePaths = [];
    return _files;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  Future<void> refresh() async {
    _files = await loadFilesFromDirectory();
    ref.notifyListeners();
  }

  bool isSelected(File file) => _selectedFilePaths.contains(file.path);

  void toggleFileSelection(File file) {
    final b = selectedFiles.length == 1;
    if (isSelected(file)) {
      _selectedFilePaths.remove(file.path);
      if (b) toggleSelectingMode();
    } else {
      _selectedFilePaths.add(file.path);
    }
    ref.notifyListeners();
  }

  bool get isSelectingMode => _isSelectingMode;

  bool get isAllSelected => _selectedFilePaths.length == fileList.length;

  void toggleSelectAll() {
    if (isAllSelected) {
      _selectedFilePaths = [];
      if (isSelectingMode) toggleSelectingMode();
    } else {
      _selectedFilePaths = fileList.map((e) => e.path).toList();
    }
    ref.notifyListeners();
  }

  void toggleSelectingMode() {
    _isSelectingMode = !_isSelectingMode;
    if (!_isSelectingMode) {
      _selectedFilePaths = [];
    }
    ref.notifyListeners();
  }

  List<File> get rawFiles => _files;

  List<File> get selectedFiles =>
      _selectedFilePaths.map((e) => File(e)).toList();

  List<File> get fileList {
    if (searchCntrlr.text.isEmpty) return _files;
    return _files.where((e) => e.path.contains(searchCntrlr.text)).toList();
  }

  Future<void> openSelectedFiles() async {
    try {
      for (final e in selectedFiles) {
        await FileHandle.openDocument(e);
      }
    } catch (e) {
      EasyLoading.showError('$e');
    }
  }

  Future<void> deleteSelectedFiles() async {
    try {
      for (final e in selectedFiles) {
        await FileHandle.deleteDocument(e);
      }
    } catch (e) {
      EasyLoading.showError('$e');
    }
  }

  Future<void> shareSelectedFiles() async {
    try {
      await FileHandle.shareDocuments(selectedFiles);
    } catch (e) {
      EasyLoading.showError('$e');
    }
  }

  Future<void> printSelectedFiles() async {
    try {
      await FileHandle.printDocuments(selectedFiles);
    } catch (e) {
      EasyLoading.showError('$e');
    }
  }
}
