import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../../config/constants.dart';
import '../../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../shared/substring_highlight/substring_highlight.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../../model/order.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class CustomerInfos extends StatelessWidget {
  const CustomerInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainMin,
      children: [
        const InfoTitle('Customer Information'),
        _KTextFormField(
          notifier: notifier,
          controller: notifier.customerNameCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Name',
            hintText: 'Enter customer\'s name...',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Customer name is required';
            }
            return null;
          },
          suggestionsCallback: (q) async => notifier.orders.where((order) =>
              order.customerName.toLowerCase().contains(q.toLowerCase())),
        ),
        const SizedBox(height: 10),
        _KTextFormField(
          notifier: notifier,
          controller: notifier.customerEmailCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Email',
            hintText: 'Enter customer\'s email address...',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v!.isNotEmpty && !v.isEmail) {
              return 'Invalid email';
            }
            return null;
          },
          suggestionsCallback: (q) async => notifier.orders.where((order) =>
              order.customerEmail?.toLowerCase().contains(q.toLowerCase()) ??
              false),
        ),
        const SizedBox(height: 10),
        _KTextFormField(
          notifier: notifier,
          controller: notifier.customerPhoneCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Phone',
            hintText: 'Enter customer\'s phone number...',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Phone number is required';
            }
            if (!v.isPhone) {
              return 'Invalid phone number';
            }
            return null;
          },
          suggestionsCallback: (q) async => notifier.orders.where((order) =>
              order.customerPhone.toLowerCase().contains(q.toLowerCase())),
        ),
        const SizedBox(height: 10),
        _KTextFormField(
          notifier: notifier,
          controller: notifier.customerAddressCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Address',
            hintText: 'Enter customer\'s address...',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
          suggestionsCallback: (q) async => notifier.orders.where((order) =>
              order.customerAddress?.toLowerCase().contains(q.toLowerCase()) ??
              false),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.customerNoteCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Note',
            hintText: 'Enter customer\'s note (if any)...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
      ],
    );
  }
}

class _KTextFormField extends StatelessWidget {
  const _KTextFormField({
    required this.notifier,
    required this.validator,
    required this.controller,
    required this.decoration,
    required this.keyboardType,
    required this.textInputAction,
    required this.suggestionsCallback,
  });

  final AddOrderProvider notifier;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FutureOr<Iterable<PktbsOrder>> Function(String) suggestionsCallback;

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      onSuggestionSelected: (PktbsOrder order) {
        notifier.customerNameCntrlr.text = order.customerName;
        notifier.customerEmailCntrlr.text = order.customerEmail ?? '';
        notifier.customerPhoneCntrlr.text = order.customerPhone;
        notifier.customerAddressCntrlr.text = order.customerAddress ?? '';
        notifier.customerNoteCntrlr.text = order.customerNote ?? '';
        //
        notifier.measurementCntrlr.text = order.measurement ?? '';
        notifier.plateCntrlr.text = order.plate ?? '';
        notifier.sleeveCntrlr.text = order.sleeve ?? '';
        notifier.colarCntrlr.text = order.colar ?? '';
        notifier.pocketCntrlr.text = order.pocket ?? '';
        notifier.buttonCntrlr.text = order.button ?? '';
        notifier.measurementNoteCntrlr.text = order.measurementNote ?? '';
      },
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: decoration,
        onSubmitted: (_) async => notifier.submit(context),
        textInputAction: textInputAction,
        keyboardType: keyboardType,
      ),
      suggestionsCallback: suggestionsCallback,
      itemBuilder: (_, PktbsOrder order) => Card(
        child: KListTile(
          title: SubstringHighlight(
            text: order.customerName,
            term: controller.text,
            textStyle: context.text.labelLarge!,
            textStyleHighlight: context.text.labelLarge!
                .copyWith(color: context.theme.primaryColor),
          ),
          subtitle: SubstringHighlight(
            text: order.customerPhone,
            term: controller.text,
            textStyle: context.text.labelMedium!,
            textStyleHighlight: context.text.labelMedium!
                .copyWith(color: context.theme.primaryColor),
          ),
        ),
      ),
      hideOnEmpty: true,
      hideOnLoading: true,
      getImmediateSuggestions: true,
      keepSuggestionsOnLoading: false,
      hideSuggestionsOnKeyboardHide: true,
      animationDuration: const Duration(milliseconds: 200),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
