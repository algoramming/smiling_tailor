import 'package:flutter/material.dart';

import '../../../../../utils/extensions/extensions.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class MeasurementInfos extends StatelessWidget {
  const MeasurementInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoTitle('Measurement Information'),
        TextFormField(
          controller: notifier.measurementCntrlr,
          decoration: const InputDecoration(
            labelText: 'Measurement',
            hintText: 'Enter customer\'s measurement...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.plateCntrlr,
          decoration: const InputDecoration(
            labelText: 'Plate',
            hintText: 'Enter customer\'s plate\'s info...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.sleeveCntrlr,
          decoration: const InputDecoration(
            labelText: 'Sleeve',
            hintText: 'Enter customer\'s sleeve\'s info...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.colarCntrlr,
          decoration: const InputDecoration(
            labelText: 'Colar/Neck',
            hintText: 'Enter customer\'s colar/neck\'s info...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.pocketCntrlr,
          decoration: const InputDecoration(
            labelText: 'Pocket',
            hintText: 'Enter customer\'s pocket\'s info...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.buttonCntrlr,
          decoration: const InputDecoration(
            labelText: 'Button',
            hintText: 'Enter customer\'s button\'s info...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.measurementNoteCntrlr,
          decoration: const InputDecoration(
            labelText: 'Measuremnt Note',
            hintText: 'Enter measurement\'s note (if any)...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: notifier.quantityCntrlr,
          decoration: const InputDecoration(
            labelText: 'Quantity',
            hintText: 'Enter quantity of this measurement...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Quantity is required';
            }
            if (!v.isNumeric) {
              return 'Invalid quantity';
            }
            if (!v.isInt) {
              return 'Quantity must be an integer';
            }
            return null;
          },
        ),
      ],
    );
  }
}
