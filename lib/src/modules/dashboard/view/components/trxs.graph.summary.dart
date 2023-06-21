import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/db/db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/constants.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../../../shared/radio_button/k_radio_button.dart';
import '../../../../shared/text.size/text.size.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/trxs.graph.summary.provider.dart';

class TrxsGraphSummary extends ConsumerWidget {
  const TrxsGraphSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(trxSummaryProvider).when(
          loading: () => const LoadingWidget(withScaffold: false),
          error: (err, _) => KErrorWidget(error: err),
          data: (_) {
            final notifier = ref.watch(trxSummaryProvider.notifier);
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Builder(builder: (_) {
                    final width = calculateTextSize('Transaction Summary',
                            style: context.text.titleLarge)
                        .width;
                    return Row(
                      mainAxisAlignment: mainCenter,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Transaction Summary',
                              style: context.text.titleLarge,
                            ),
                            const SizedBox(height: 2.0),
                            Container(
                              height: 1.8,
                              width: width,
                              color:
                                  context.theme.primaryColor.withOpacity(0.5),
                            ),
                            const SizedBox(height: 2.0),
                            Container(
                              height: 1.8,
                              width: width,
                              color:
                                  context.theme.primaryColor.withOpacity(0.7),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: crossEnd,
                          children: [
                            Transform.scale(
                              alignment: Alignment.bottomRight,
                              scale: 0.7,
                              child: Switch.adaptive(
                                value: notifier.isGoods,
                                onChanged: (_) => notifier.toggleIsGoods(),
                              ),
                            ),
                            Text(
                              !notifier.isGoods
                                  ? '...Showing Financials Transactions'
                                  : '...Showing Goods Transactions',
                              style: context.text.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: mainSpaceEvenly,
                    children: [
                      KRadioButton(
                        value: 0,
                        label: 'Annual Statement',
                        groupValue: notifier.summaryRadio,
                        onTap: notifier.changeSummaryRadio,
                      ),
                      KRadioButton(
                        value: 1,
                        label: 'Monthly Statement',
                        groupValue: notifier.summaryRadio,
                        onTap: notifier.changeSummaryRadio,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(
                      text: notifier.summaryRadio == 0
                          ? 'Annual Statement'
                          : 'Monthly Statement',
                      textStyle: TextStyle(
                        color: context.theme.primaryColor,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    legend:
                        Legend(isVisible: true, position: LegendPosition.top),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<GraphData, String>>[
                      LineSeries<GraphData, String>(
                        dataSource: notifier.graphData,
                        xValueMapper: (GraphData sales, _) => sales.feature,
                        yValueMapper: (GraphData sales, _) => sales.value,
                        name: notifier.isGoods
                            ? 'Pcs'
                            : '${appCurrency.symbol} ${appCurrency.shortForm}',
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
  }
}
