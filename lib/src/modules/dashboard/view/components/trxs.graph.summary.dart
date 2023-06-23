import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/constants.dart';
import '../../../../db/db.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/gradient/gradient.widget.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../../../shared/radio_button/k_radio_button.dart';
import '../../../../shared/text.size/text.size.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../settings/provider/date.format.provider.dart';
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
                            GradientWidget(
                              child: Container(
                                height: 1.8,
                                width: width,
                                color:
                                    context.theme.primaryColor.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            GradientWidget(
                              child: Container(
                                height: 1.8,
                                width: width,
                                color:
                                    context.theme.primaryColor.withOpacity(0.7),
                              ),
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
                        label: 'Monthly Statement',
                        groupValue: notifier.summaryRadio,
                        onTap: notifier.changeSummaryRadio,
                      ),
                      KRadioButton(
                        value: 1,
                        label: 'Annual Statement',
                        groupValue: notifier.summaryRadio,
                        onTap: notifier.changeSummaryRadio,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SfCartesianChart(
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(
                      text: notifier.summaryRadio == 0
                          ? 'Monthly Statement'
                          : 'Annual Statement',
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
                        color: context.theme.primaryColor,
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
                  const SizedBox(height: 10.0),
                  Card(
                    child: Row(
                      mainAxisAlignment: mainSpaceBetween,
                      children: [
                        InkWell(
                          borderRadius: borderRadius45,
                          onTap: () => notifier.decreaseDate(),
                          child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 15.0),
                            margin:
                                const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        InkWell(
                          borderRadius: borderRadius15,
                          onTap: () async => await showDatePicker(
                            context: context,
                            initialDate: notifier.selectedDate,
                            firstDate: notifier.selectedDate
                                .subtract(const Duration(days: 365 * 100)),
                            lastDate: DateTime.now(),
                            selectableDayPredicate: (day) =>
                                day.day == DateTime.now().day,
                            builder: (_, child) => Theme(
                              data: context.theme.copyWith(
                                  colorScheme: context.theme.colorScheme
                                      .copyWith(
                                          primary: context.theme.primaryColor)),
                              child: child!,
                            ),
                          ).then((pk) => notifier.changeDate(pk)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              DateFormat(dateFormates[1])
                                  .format(notifier.selectedDate),
                              style: context.text.titleLarge,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: borderRadius45,
                          onTap: !notifier.canIncreaseDate
                              ? null
                              : () => notifier.increaseDate(),
                          child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 15.0, 5.0, 15.0),
                            margin:
                                const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: !notifier.canIncreaseDate
                                  ? context.theme.dividerColor
                                  : context.theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
