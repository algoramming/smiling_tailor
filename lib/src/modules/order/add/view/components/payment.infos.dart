import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../db/db.dart';
import '../../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../../enum/order.enum.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class PaymentInfos extends StatelessWidget {
  const PaymentInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoTitle('Payment Information'),
        DropdownButtonFormField(
          borderRadius: borderRadius12,
          value: notifier.paymentMethod,
          decoration: const InputDecoration(
            labelText: 'Payment Method',
            hintText: 'Select payment method...',
          ),
          onChanged: (v) => notifier.setPaymentMethod(v!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: PaymentMethod.values
              .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
              .toList(),
          validator: (v) {
            if (v == null) {
              return 'Payment method selection is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.vatCntrlr,
          decoration: const InputDecoration(
            labelText: 'Vat',
            hintText: 'Enter vat amount(if any) ...',
            suffixIcon: CurrencySuffixIcon(),
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          onChanged: (_) => notifier.reload(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Vat amount is required';
            }
            if (!v.isNumeric) {
              return 'Invalid amount';
            }
            return null;
          },
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.centerRight,
          child: Builder(builder: (_) {
            final vat = notifier.vatCntrlr.text.toString().toDouble ?? 0.0;
            return Text(
              'Vat: $vat${appCurrency.symbol}',
              style: context.text.labelMedium,
            );
          }),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: notifier.discountCntrlr,
          decoration: const InputDecoration(
            labelText: 'Discount',
            hintText: 'Enter discount amount(if any) ...',
            suffixIcon: CurrencySuffixIcon(),
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          onChanged: (_) => notifier.reload(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Discount amount is required';
            }
            if (!v.isNumeric) {
              return 'Invalid amount';
            }
            return null;
          },
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.centerRight,
          child: Builder(builder: (_) {
            final discount =
                notifier.discountCntrlr.text.toString().toDouble ?? 0.0;
            return Text(
              'Discount: $discount${appCurrency.symbol}',
              style: context.text.labelMedium,
            );
          }),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: notifier.advanceAmountCntrlr,
          decoration: const InputDecoration(
            labelText: 'Advance Amount',
            hintText: 'Enter advance amount...',
            suffixIcon: CurrencySuffixIcon(),
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          onChanged: (_) => notifier.reload(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Paid amount is required';
            }
            if (!v.isNumeric) {
              return 'Invalid amount';
            }
            return null;
          },
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.centerRight,
          child: Builder(builder: (context) {
            final total =
                (notifier.tailorChargeCntrlr.text.toString().toDouble ?? 0.0) +
                    (notifier.inventoryPriceCntrlr.text.toString().toDouble ??
                        0.0) +
                    (notifier.deliveryChargeCntrlr.text.toString().toDouble ??
                        0.0) +
                    (notifier.vatCntrlr.text.toString().toDouble ?? 0.0) -
                    (notifier.discountCntrlr.text.toString().toDouble ?? 0.0);
            return Text(
              'Total: $total${appCurrency.symbol} and Remaining: ${total - (notifier.advanceAmountCntrlr.text.toString().toDouble ?? 0.0)}${appCurrency.symbol}',
              style: context.text.labelMedium,
            );
          }),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: notifier.paymentNoteCntrlr,
          decoration: const InputDecoration(
            labelText: 'Payment Note',
            hintText: 'Enter payment note (if any)...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) => null,
        ),
      ],
    );
  }
}
