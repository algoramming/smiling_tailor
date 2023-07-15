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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: notifier.vatCntrlr,
                decoration: InputDecoration(
                  labelText: 'Vat',
                  hintText: 'Enter vat amount(if any) ...',
                  suffixIcon: CurrencySuffixIcon(
                    text: notifier.isVatPercentage ? '%' : appCurrency.symbol,
                  ),
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
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: notifier.toggleVatPercentage,
              child: Container(
                height: 48.0,
                width: 25.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: borderRadius10,
                  color: !notifier.isVatPercentage
                      ? context.theme.dividerColor.withOpacity(0.15)
                      : context.theme.primaryColor.withOpacity(0.15),
                  border: Border.all(
                    color: !notifier.isVatPercentage
                        ? context.theme.dividerColor.withOpacity(0.5)
                        : context.theme.primaryColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  '%',
                  style: context.text.titleMedium,
                ),
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: notifier.toggleVatPercentage,
              child: Container(
                height: 48.0,
                width: 25.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: borderRadius10,
                  color: notifier.isVatPercentage
                      ? context.theme.dividerColor.withOpacity(0.15)
                      : context.theme.primaryColor.withOpacity(0.15),
                  border: Border.all(
                    color: notifier.isVatPercentage
                        ? context.theme.dividerColor.withOpacity(0.5)
                        : context.theme.primaryColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  appCurrency.symbol,
                  style: context.text.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Vat: ${notifier.vat}${appCurrency.symbol}',
            style: context.text.labelMedium,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: notifier.discountCntrlr,
                decoration: InputDecoration(
                  labelText: 'Discount',
                  hintText: 'Enter discount amount(if any) ...',
                  suffixIcon: CurrencySuffixIcon(
                    text: notifier.isDiscountPercentage
                        ? '%'
                        : appCurrency.symbol,
                  ),
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
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: notifier.toggleDiscountPercentage,
              child: Container(
                height: 48.0,
                width: 25.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: borderRadius10,
                  color: !notifier.isDiscountPercentage
                      ? context.theme.dividerColor.withOpacity(0.15)
                      : context.theme.primaryColor.withOpacity(0.15),
                  border: Border.all(
                    color: !notifier.isDiscountPercentage
                        ? context.theme.dividerColor.withOpacity(0.5)
                        : context.theme.primaryColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  '%',
                  style: context.text.titleMedium,
                ),
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: notifier.toggleDiscountPercentage,
              child: Container(
                height: 48.0,
                width: 25.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: borderRadius10,
                  color: notifier.isDiscountPercentage
                      ? context.theme.dividerColor.withOpacity(0.15)
                      : context.theme.primaryColor.withOpacity(0.15),
                  border: Border.all(
                    color: notifier.isDiscountPercentage
                        ? context.theme.dividerColor.withOpacity(0.5)
                        : context.theme.primaryColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  appCurrency.symbol,
                  style: context.text.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Discount: ${notifier.discount}${appCurrency.symbol}',
            style: context.text.labelMedium,
          ),
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
          child: Text(
            'Total: ${notifier.grandTotal}${appCurrency.symbol} and Remaining: ${notifier.grandTotal - (notifier.advanceAmountCntrlr.text.toString().toDouble ?? 0.0)}${appCurrency.symbol}',
            style: context.text.labelMedium,
          ),
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
