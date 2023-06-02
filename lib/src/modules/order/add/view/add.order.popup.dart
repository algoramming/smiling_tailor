import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/db/isar.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';

import '../../../../constants/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/date_time_picker/k_date_time_picker.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/enum.dart';
import '../provider/add.order.provider.dart';

class AddOrderPopup extends ConsumerWidget {
  const AddOrderPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        title: const Text('Add Order'),
        content: SizedBox(
          width: min(400, context.width),
          child: Form(
            key: notifier.formKey,
            child: Column(
              mainAxisSize: mainMin,
              children: [
                const _Title('Customer Information'),
                TextFormField(
                  controller: notifier.customerNameCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    hintText: 'Enter customer\'s name...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Customer name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.customerEmailCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Customer Email',
                    hintText: 'Enter customer\'s email address...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v!.isNotEmpty && !v.isEmail) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.customerPhoneCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Customer Phone',
                    hintText: 'Enter customer\'s phone number...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.customerPhoneCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Customer Address',
                    hintText: 'Enter customer\'s address...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.customerPhoneCntrlr,
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
                const _Title('Measurement Information'),
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
                const _Title('Inventory Information'),
                DropdownButtonFormField(
                  borderRadius: borderRadius15,
                  value: notifier.inventory,
                  decoration: const InputDecoration(
                    labelText: 'Inventory',
                    hintText: 'Select inventory to allocate this order...',
                  ),
                  onChanged: (v) => notifier.setInventory(v!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: notifier.inventories
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.title)))
                      .toList(),
                  validator: (v) {
                    if (v == null) {
                      return 'Inventory selection is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: notifier.inventoryQuantityCntrlr,
                    decoration: InputDecoration(
                      labelText: 'Inventory Quantity',
                      hintText: 'Enter inventory\'s quantity...',
                      suffixIcon: AnimatedWidgetShower(
                        size: 28.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Center(
                            child: Text(
                              notifier.inventoryUnit?.symbol ?? '??',
                              style: context.text.labelLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onFieldSubmitted: (_) async => notifier.submit(context),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Quantity is required';
                      }
                      if (!v.isNumeric) {
                        return 'Invalid quantity';
                      }
                      if (!v.isInt) {
                        return 'Quantity must be integer';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.inventoryPriceCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Inventory Charge',
                    hintText: 'Enter inventory charge...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Inventory Charge is required';
                    }
                    if (!v.isNumeric) {
                      return 'Invalid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.inventoryNoteCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Inventory Note',
                    hintText: 'Enter inventory note (if any)...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
                ),
                const _Title('Employee Allocation'),
                DropdownButtonFormField(
                  borderRadius: borderRadius15,
                  value: notifier.tailorEmployee,
                  decoration: const InputDecoration(
                    labelText: 'Employee',
                    hintText: 'Select employee to allocate this order...',
                  ),
                  onChanged: (v) => notifier.setTailorEmployee(v!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: notifier.employees
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  validator: (v) {
                    if (v == null) {
                      return 'Employee selection is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.tailorChargeCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Tailoring Charge',
                    hintText: 'Enter tailoring charge...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Tailoring Charge is required';
                    }
                    if (!v.isNumeric) {
                      return 'Invalid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.tailorNoteCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Tailoring Note',
                    hintText: 'Enter tailoring note (if any)...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
                ),
                const _Title('Delivery Information'),
                SwitchListTile.adaptive(
                  title: const Text('Is Home Delivery Needed?'),
                  value: notifier.isHomeDeliveryNeeded,
                  onChanged: (_) => notifier.toggleHomeDelivery(),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  borderRadius: borderRadius15,
                  value: notifier.deliveryEmployee,
                  decoration: const InputDecoration(
                    labelText: 'Delivery Employee',
                    hintText: 'Select employee to delivery this order...',
                  ),
                  onChanged: (v) => notifier.setDeliveryEmployee(v!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: notifier.employees
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  validator: (v) {
                    if (v == null) {
                      return 'Employee selection is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.deliveryNoteCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Delivery Address',
                    hintText: 'Enter delivery address...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.deliveryChargeCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Delivery Charge',
                    hintText: 'Enter delivery charge...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isNotEmpty && !v.isNumeric) {
                      return 'Invalid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.deliveryNoteCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Delivery Note',
                    hintText: 'Enter delivery note (if any)...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
                ),
                const _Title('Payment Information'),
                DropdownButtonFormField(
                  borderRadius: borderRadius15,
                  value: notifier.paymentMethod,
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                    hintText: 'Select payment method...',
                  ),
                  onChanged: (v) => notifier.setPaymentMethod(v!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: PaymentMethod.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.label)))
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
                  controller: notifier.advanceCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Advance Amount',
                    hintText: 'Enter advance amount...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.deliveryNoteCntrlr,
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
                const _Title('Others Information'),
                // TimePicker
                InkWell(
                  onTap: () async => await selectDateTimeFromPicker(
                          context, notifier.deliveryTime)
                      .then((dt) {
                    if (dt == null) return;
                    notifier.setDeliveryTime(dt);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius12,
                      border: Border.all(
                          color: context.text.bodyLarge!.color!, width: 1.0),
                    ),
                    child: Text(
                      appSettings.getDateTimeFormat
                          .format(notifier.deliveryTime),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  borderRadius: borderRadius15,
                  value: notifier.status,
                  decoration: const InputDecoration(
                    labelText: 'Order Status',
                    hintText: 'Select order status...',
                  ),
                  onChanged: (v) => notifier.setOrderStatus(v!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: OrderStatus.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.label)))
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
                  controller: notifier.descriptionCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description (if any)...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (v) => null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async => await notifier.submit(context),
            child: Text('Add Order',
                style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Customer Information',
          style: context.text.labelLarge!
              .copyWith(color: context.theme.primaryColor),
        ),
      ),
    );
  }
}
