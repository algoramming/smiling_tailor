import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  FutureOr<List<PktbsTrx>> build() async {
    _trxs = [];
    ref.watch(allTrxsProvider);
    _trxs = (await ref.watch(allTrxsProvider.future));
    _isGoodsTrxs = _trxs.where((e) => e.isGoods).toList();
    _isNotGoodsTrxs = _trxs.where((e) => !e.isGoods).toList();
    return _trxs;
  }

  bool get isGoods => _isGoods;

  void toggleIsGoods() {
    _isGoods = !_isGoods;
    ref.notifyListeners();
  }

  int get summaryRadio => _summaryRadio;

  void changeSummaryRadio() {
    _summaryRadio = _summaryRadio == 0 ? 1 : 0;
    ref.notifyListeners();
  }

  List<GraphData> get graphData {
    final List<GraphData> graphData = [];
    final trxs = _isGoods ? _isGoodsTrxs : _isNotGoodsTrxs;

    if (_summaryRadio == 1) {
      for (final mn in monthNames) {
        final filteredTrxs = trxs
            .where((trx) => monthNames[trx.created.month - 1] == mn)
            .toList();
        final double total = filteredTrxs.fold(0, (p, c) => p + c.amount);
        graphData.add(GraphData(mn, total));
      }
      return graphData;
    } else {
      for (int i = 1; i <= 31; i++) {
        final todayMonth = DateTime.now().month;
        final todayDay = DateTime.now().day;
        final filteredTrxs = trxs
            .where((trx) =>
                trx.created.month == todayMonth && trx.created.day == todayDay)
            .toList();
        final double total = filteredTrxs.fold(0, (p, c) => p + c.amount);
        graphData.add(GraphData('$i', total));
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
