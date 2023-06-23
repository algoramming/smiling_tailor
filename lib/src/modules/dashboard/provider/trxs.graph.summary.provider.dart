import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../transaction/enum/trx.type.dart';
import '../../transaction/model/transaction.dart';
import '../../transaction/provider/all.trxs.provider.dart';

typedef TrxSummaryNotifier
    = AsyncNotifierProvider<TrxSummaryProvider, List<PktbsTrx>>;

final trxSummaryProvider = TrxSummaryNotifier(TrxSummaryProvider.new);

class TrxSummaryProvider extends AsyncNotifier<List<PktbsTrx>> {
  late List<PktbsTrx> _trxs;
  late List<PktbsTrx> _isGoodsTrxs;
  late List<PktbsTrx> _isNotGoodsTrxs;
  bool _isGoods = false;
  int _summaryRadio = 0; // 0 = monthly, 1 = yearly
  DateTime? _selectedDate;
  @override
  FutureOr<List<PktbsTrx>> build() async {
    _trxs = [];
    ref.watch(allTrxsProvider);
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) => trx.isActive)
        .toList();
    _isGoodsTrxs = _trxs.where((e) => e.isGoods).toList();
    _isNotGoodsTrxs = _trxs.where((e) => !e.isGoods).toList();
    return _trxs;
  }

  bool get isGoods => _isGoods;

  DateTime get selectedDate => _selectedDate ?? DateTime.now();

  void toggleIsGoods() {
    _isGoods = !_isGoods;
    ref.notifyListeners();
  }

  int get summaryRadio => _summaryRadio;

  void changeSummaryRadio() {
    _summaryRadio = _summaryRadio == 0 ? 1 : 0;
    ref.notifyListeners();
  }

  void decreaseDate() {
    if (summaryRadio == 0) {
      _selectedDate = selectedDate.previousMonth;
    } else {
      _selectedDate = selectedDate.previousYear;
    }
    ref.notifyListeners();
  }

  bool get canIncreaseDate {
    DateTime tempDate = selectedDate;
    if (summaryRadio == 0) {
      tempDate = tempDate.nextMonth;
    } else {
      tempDate = tempDate.nextYear;
    }
    return tempDate.isBefore(DateTime.now());
  }

  void increaseDate() {
    if (summaryRadio == 0) {
      _selectedDate = selectedDate.nextMonth;
    } else {
      _selectedDate = selectedDate.nextYear;
    }
    ref.notifyListeners();
  }

  void changeDate(DateTime? date) {
    if (date == null) return;
    _selectedDate = date;
    ref.notifyListeners();
  }

  List<GraphData> get graphData {
    final List<GraphData> graphData = [];
    final trxs = _isGoods ? _isGoodsTrxs : _isNotGoodsTrxs;

    if (_summaryRadio == 0) {
      for (int i = 1; i <= selectedDate.totalDaysInMonth; i++) {
        final month = selectedDate.month;
        final year = selectedDate.year;
        final filteredTrxs = trxs
            .where((trx) =>
                trx.created.year == year &&
                trx.created.month == month &&
                trx.created.day == i)
            .toList();
        final double total = filteredTrxs.fold(
            0, (p, c) => p + (c.trxType.isCredit ? -c.amount : c.amount));
        graphData.add(GraphData('$i', total));
      }
      return graphData;
    } else {
      for (final mn in monthNames) {
        final filteredTrxs = trxs
            .where((trx) =>
                monthNames[trx.created.month - 1] == mn &&
                trx.created.year == selectedDate.year)
            .toList();
        final double total = filteredTrxs.fold(
            0, (p, c) => p + (c.trxType.isCredit ? -c.amount : c.amount));
        graphData.add(GraphData(mn, total));
      }
      return graphData;
    }
  }
}

class GraphData {
  final String feature;
  final double value;

  GraphData(this.feature, this.value);
}

const monthNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
