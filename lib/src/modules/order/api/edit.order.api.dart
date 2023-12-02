import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../db/db.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../transaction/api/trx.api.dart';
import '../../transaction/enum/trx.type.dart';
import '../../transaction/model/transaction.dart';
import '../add/provider/add.order.provider.dart';
import '../add/view/order.slip.download.popup.dart';
import '../enum/order.enum.dart';
import '../model/order.dart';

Future<void> pktbsUpdateOrder(BuildContext ctx, AddOrderProvider noti) async {
  try {
    EasyLoading.show(status: 'Updating Order...');
    await pb.collection(orders).update(
      noti.arg!.id,
      body: {
        'customerName': noti.customerNameCntrlr.text,
        'customerEmail': noti.customerEmailCntrlr.text,
        'customerPhone': noti.customerPhoneCntrlr.text,
        'customerAddress': noti.customerAddressCntrlr.text,
        'customerNote': noti.customerNoteCntrlr.text,
        'measurement': noti.measurementCntrlr.text,
        'plate': noti.plateCntrlr.text,
        'sleeve': noti.sleeveCntrlr.text,
        'colar': noti.colarCntrlr.text,
        'pocket': noti.pocketCntrlr.text,
        'button': noti.buttonCntrlr.text,
        'measurementNote': noti.measurementNoteCntrlr.text,
        'quantity': noti.quantityCntrlr.text.toInt,
        'tailorEmployee': noti.tailorEmployee!.id,
        // 'tailorCharge': notifier.tailorChargeCntrlr.text.toDouble,
        'tailorNote': noti.tailorNoteCntrlr.text,
        'inventory': noti.inventory!.id,
        // 'inventoryQuantity': noti.inventoryQuantityCntrlr.text.toInt,
        // 'inventoryUnit': noti.inventoryUnit!.name,
        // 'inventoryPrice': notifier.inventoryPriceCntrlr.text.toDouble,
        'inventoryNote': noti.inventoryNoteCntrlr.text,
        'deliveryEmployee': noti.deliveryEmployee?.id,
        'deliveryAddress': noti.deliveryAddressCntrlr.text,
        // 'deliveryCharge': notifier.deliveryChargeCntrlr.text.toDouble,
        'deliveryNote': noti.deliveryNoteCntrlr.text,
        'paymentMethod': noti.paymentMethod.label,
        'paymentNote': noti.paymentNoteCntrlr.text,
        // 'amount': notifier.advanceAmountCntrlr.text.toDouble,
        'vat': noti.vat,
        'discount': noti.discount,
        'amount': noti.grandTotal,
        'deliveryTime': noti.deliveryTime.toUtc().toIso8601String(),
        'description': noti.descriptionCntrlr.text,
        'status': noti.status.label,
        'updator': pb.authStore.model!.id
      },
    ).then(
      (r) async => await pb
          .collection(orders)
          .getOne(r.toJson()['id'], expand: pktbsOrderExpand)
          .then((i) async {
        final order = PktbsOrder.fromJson(i.toJson());
        // advance amount trx
        await pktbsUpdateTrx(
          ctx,
          noti.advanceTrx!.copyWith(
            fromId: order.id,
            from: order.toJson(),
            toId: pb.authStore.model?.id,
            to: pb.authStore.model?.toJson(),
            amount: noti.advanceAmountCntrlr.text.toDouble ?? 0.0,
            voucher: advanceAmountOrderVoucher,
            trxType: TrxType.debit,
            description:
                'System Generated: Transaction for advance amount of order ${order.id}',
            isSystemGenerated: true,
          ),
        ).then((_) async => await _updateTrxs(ctx, order, noti));
      }),
    );
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('Order Creation: $e');
    if (!ctx.mounted) return;
    showAwesomeSnackbar(
        ctx, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> _updateTrxs(
  BuildContext ctx,
  PktbsOrder order,
  AddOrderProvider noti,
) async {
  // if tailor needed
  if (noti.allocateTailorNow) {
    await _tailorAllocateApi(ctx, order, noti).then((_) async {
      // if inventory needed
      if (noti.isInventoryNeeded) {
        await _inventoryAllocateApi(ctx, order, noti).then((_) async {
          // if delivery needed
          if (noti.isHomeDeliveryNeeded) {
            await _deliveryAllocationApi(ctx, order, noti).then((_) async {
              log.f(
                  'order added successfully with - 4 - advance, tailor, inventory and delivery allocation!');
              //
              await _deleteTrxs(ctx, order, noti);
              //
              // noti.clear();
              // ctx.pop();
              // EasyLoading.dismiss();
              // await showOrderSlipDownloadPopup(ctx, order);
              //
              // showAwesomeSnackbar(ctx, 'Success!',
              //     'Order added successfully.', MessageType.success);
            });
          } else {
            log.f(
                'order added successfully with - 3 - advance, tailor and inventory allocation!');
            //
            await _deleteTrxs(ctx, order, noti);
            //
            // noti.clear();
            // ctx.pop();
            // EasyLoading.dismiss();
            // await showOrderSlipDownloadPopup(ctx, order);
            //
            // showAwesomeSnackbar(ctx, 'Success!',
            //     'Order added successfully.', MessageType.success);
          }
        });
      } else {
        // if delivery needed
        if (noti.isHomeDeliveryNeeded) {
          await _deliveryAllocationApi(ctx, order, noti).then((_) async {
            log.f(
                'order added successfully with - 3 - advance, tailor and delivery allocation!');
            //
            await _deleteTrxs(ctx, order, noti);
            //
            // noti.clear();
            // ctx.pop();
            // EasyLoading.dismiss();
            // await showOrderSlipDownloadPopup(ctx, order);
            //
            // showAwesomeSnackbar(ctx, 'Success!',
            //     'Order added successfully.', MessageType.success);
          });
        } else {
          log.f(
              'order added successfully with - 2 - advance and tailor allocation!');
          //
          await _deleteTrxs(ctx, order, noti);
          //
          // noti.clear();
          // ctx.pop();
          // EasyLoading.dismiss();
          // await showOrderSlipDownloadPopup(ctx, order);
          //
          // showAwesomeSnackbar(ctx, 'Success!',
          //     'Order added successfully.', MessageType.success);
        }
      }
    });
  } else {
    // if inventory needed
    if (noti.isInventoryNeeded) {
      await _inventoryAllocateApi(ctx, order, noti).then((_) async {
        // if delivery needed
        if (noti.isHomeDeliveryNeeded) {
          await _deliveryAllocationApi(ctx, order, noti).then((_) async {
            log.f(
                'order added successfully with - 3 - advance, inventory and delivery allocation!');
            //
            await _deleteTrxs(ctx, order, noti);
            //
            // noti.clear();
            // ctx.pop();
            // EasyLoading.dismiss();
            // await showOrderSlipDownloadPopup(ctx, order);
            //
            // showAwesomeSnackbar(ctx, 'Success!',
            //     'Order added successfully.', MessageType.success);
          });
        } else {
          log.f(
              'order added successfully with - 2 - advance and inventory allocation!');
          //
          await _deleteTrxs(ctx, order, noti);
          //
          // noti.clear();
          // ctx.pop();
          // EasyLoading.dismiss();
          // await showOrderSlipDownloadPopup(ctx, order);
          //
          // showAwesomeSnackbar(ctx, 'Success!',
          //     'Order added successfully.', MessageType.success);
        }
      });
    } else {
      // if delivery needed
      if (noti.isHomeDeliveryNeeded) {
        await _deliveryAllocationApi(ctx, order, noti).then((_) async {
          log.f(
              'order added successfully with - 2 - advance and delivery allocation!');
          //
          await _deleteTrxs(ctx, order, noti);
          //
          // noti.clear();
          // ctx.pop();
          // EasyLoading.dismiss();
          // await showOrderSlipDownloadPopup(ctx, order);
          //
          // showAwesomeSnackbar(ctx, 'Success!',
          //     'Order added successfully.', MessageType.success);
        });
      } else {
        log.f('order added successfully with - 1 - advance only!');
        //
        await _deleteTrxs(ctx, order, noti);
        //
        // noti.clear();
        // ctx.pop();
        // EasyLoading.dismiss();
        // await showOrderSlipDownloadPopup(ctx, order);
        //
        // showAwesomeSnackbar(ctx, 'Success!',
        //     'Order added successfully.', MessageType.success);
      }
    }
  }
}

Future<RecordModel?> _tailorAllocateApi(
  BuildContext context,
  PktbsOrder order,
  AddOrderProvider notifier,
) {
  log.i('Need Trx for taior allocation');
  if (notifier.tailorTrx != null) {
    return pktbsUpdateTrx(
      context,
      notifier.tailorTrx!.copyWith(
        fromId: order.id,
        from: order.toJson(),
        toId: order.tailorEmployee!.id,
        to: order.tailorEmployee!.toJson(),
        trxType: TrxType.debit,
        amount: notifier.tailorChargeCntrlr.text.toDouble ?? 0.0,
        isSystemGenerated: true,
        voucher: tailorChargeOrderVoucher,
        description:
            'System Generated: Transaction for Tailor Charge of order #${order.id} allocated to ${order.tailorEmployee!.name} [${order.tailorEmployee!.id}]',
      ),
    );
  } else {
    return pktbsAddTrx(
      context,
      fromId: order.id,
      fromJson: order.toJson(),
      fromType: order.glType,
      toId: order.tailorEmployee!.id,
      toJson: order.tailorEmployee!.toJson(),
      toType: order.tailorEmployee!.glType,
      trxType: TrxType.debit,
      amount: notifier.tailorChargeCntrlr.text.toDouble ?? 0.0,
      isSystemGenerated: true,
      voucher: tailorChargeOrderVoucher,
      description:
          'System Generated: Transaction for Tailor Charge of order #${order.id} allocated to ${order.tailorEmployee!.name} [${order.tailorEmployee!.id}]',
    );
  }
}

Future<RecordModel?> _inventoryAllocateApi(
  BuildContext context,
  PktbsOrder order,
  AddOrderProvider notifier,
) {
  log.i('Need Trx for inventory purchase allocation');
  if (notifier.inventoryAllocationTrx != null) {
    return pktbsUpdateTrx(
      context,
      notifier.inventoryAllocationTrx!.copyWith(
        fromId: order.inventory!.id,
        from: order.inventory!.toJson(),
        toId: order.id,
        to: order.toJson(),
        trxType: TrxType.credit,
        amount: notifier.inventoryQuantityCntrlr.text.toDouble ?? 0.0,
        unit: notifier.inventoryUnit,
        isSystemGenerated: true,
        voucher: inventoryAllocationOrderVoucher,
        isGoods: true,
        description:
            'System Generated: Transaction for Inventory Purchase of order #${order.id} allocated to ${order.inventory!.title} [${order.inventory!.id}] by ${appCurrency.symbol}${notifier.inventoryPriceCntrlr.text.toDouble}}',
      ),
    ).then(
      (_) async => await pktbsUpdateTrx(
        context,
        notifier.inventoryPurchaseTrx!.copyWith(
          fromId: order.id,
          from: order.toJson(),
          toId: order.inventory!.id,
          to: order.inventory!.toJson(),
          trxType: TrxType.debit,
          amount: notifier.inventoryPriceCntrlr.text.toDouble ?? 0.0,
          isSystemGenerated: true,
          voucher: inventoryPurchaseOrderVoucher,
          description:
              'System Generated: Transaction for Inventory Purchase of order #${order.id} allocated to ${order.inventory!.title} [${order.inventory!.id}] of ${notifier.inventoryQuantityCntrlr.text.toDouble ?? 0.0}${notifier.inventoryUnit?.name}',
        ),
      ),
    );
  } else {
    return pktbsAddTrx(
      context,
      fromId: order.inventory!.id,
      fromJson: order.inventory!.toJson(),
      fromType: order.inventory!.glType,
      toId: order.id,
      toJson: order.toJson(),
      toType: order.glType,
      trxType: TrxType.credit,
      amount: notifier.inventoryQuantityCntrlr.text.toDouble ?? 0.0,
      unit: notifier.inventoryUnit?.name,
      isSystemGenerated: true,
      voucher: inventoryAllocationOrderVoucher,
      isGoods: true,
      description:
          'System Generated: Transaction for Inventory Purchase of order #${order.id} allocated to ${order.inventory?.title} [${order.inventory?.id}] by ${appCurrency.symbol}${notifier.inventoryPriceCntrlr.text.toDouble}}',
    ).then(
      (_) async => await pktbsAddTrx(
        context,
        fromId: order.id,
        fromJson: order.toJson(),
        fromType: order.glType,
        toId: order.inventory!.id,
        toJson: order.inventory!.toJson(),
        toType: order.inventory!.glType,
        trxType: TrxType.debit,
        amount: notifier.inventoryPriceCntrlr.text.toDouble ?? 0.0,
        isSystemGenerated: true,
        voucher: inventoryPurchaseOrderVoucher,
        description:
            'System Generated: Transaction for Inventory Purchase of order #${order.id} allocated to ${order.inventory!.title} [${order.inventory!.id}] of ${notifier.inventoryQuantityCntrlr.text.toDouble ?? 0.0}${notifier.inventoryUnit!.name}',
      ),
    );
  }
}

Future<RecordModel?> _deliveryAllocationApi(
  BuildContext context,
  PktbsOrder order,
  AddOrderProvider notifier,
) {
  log.i('Need Trx for home delivery allocation');
  if (notifier.deliveryTrx != null) {
    return pktbsUpdateTrx(
      context,
      notifier.deliveryTrx!.copyWith(
        fromId: order.id,
        from: order.toJson(),
        toId: order.deliveryEmployee!.id,
        to: order.deliveryEmployee!.toJson(),
        amount: notifier.deliveryChargeCntrlr.text.toDouble ?? 0.0,
        trxType: TrxType.debit,
        isSystemGenerated: true,
        voucher: deliveryOrderVoucher,
        description:
            'System Generated: Transaction for Delivery Charge of order #${order.id} allocated to ${order.deliveryEmployee!.name} [${order.deliveryEmployee!.id}]',
      ),
    );
  } else {
    return pktbsAddTrx(
      context,
      fromId: order.id,
      fromJson: order.toJson(),
      fromType: order.glType,
      toId: order.deliveryEmployee!.id,
      toJson: order.deliveryEmployee!.toJson(),
      toType: order.deliveryEmployee!.glType,
      amount: notifier.deliveryChargeCntrlr.text.toDouble ?? 0.0,
      trxType: TrxType.debit,
      isSystemGenerated: true,
      voucher: deliveryOrderVoucher,
      description:
          'System Generated: Transaction for Delivery Charge of order #${order.id} allocated to ${order.deliveryEmployee!.name} [${order.deliveryEmployee!.id}]',
    );
  }
}

Future<void> _deleteTrxs(
  BuildContext ctx,
  PktbsOrder order,
  AddOrderProvider noti,
) async {
  // tailor check
  if (!noti.allocateTailorNow && noti.tailorTrx != null) {
    await pktbsDeleteTrx(ctx, noti.tailorTrx!).then((_) async {
      // inventory check
      if (!noti.isInventoryNeeded &&
          noti.inventoryAllocationTrx != null &&
          noti.inventoryPurchaseTrx != null) {
        await pktbsDeleteTrx(ctx, noti.inventoryAllocationTrx!)
            .then((_) async =>
                await pktbsDeleteTrx(ctx, noti.inventoryPurchaseTrx!))
            .then((_) async {
          // delivery check
          if (!noti.isHomeDeliveryNeeded && noti.deliveryTrx != null) {
            await pktbsDeleteTrx(ctx, noti.deliveryTrx!).then((_) async {
              log.f(
                  'order trxs delete with - 3 - no tailor, inventory, delivery trx anymore!');
              noti.clear();
              ctx.pop();
              EasyLoading.dismiss();
              await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
            });
          } else {
            log.f(
                'order trxs delete with - 2 - no tailor, inventory trx anymore!');
            noti.clear();
            ctx.pop();
            EasyLoading.dismiss();
            await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
          }
        });
      } else {
        // delivery check
        if (!noti.isHomeDeliveryNeeded && noti.deliveryTrx != null) {
          await pktbsDeleteTrx(ctx, noti.deliveryTrx!).then((_) async {
            log.f(
                'order trxs delete with - 2 - no tailor, delivery trx anymore!');
            noti.clear();
            ctx.pop();
            EasyLoading.dismiss();
            await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
          });
        } else {
          log.f('order trxs delete with - 1 - no tailor trx anymore!');
          noti.clear();
          ctx.pop();
          EasyLoading.dismiss();
          await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
        }
      }
    });
  } else {
    // inventory check
    if (!noti.isInventoryNeeded &&
        noti.inventoryAllocationTrx != null &&
        noti.inventoryPurchaseTrx != null) {
      await pktbsDeleteTrx(ctx, noti.inventoryAllocationTrx!)
          .then((_) async =>
              await pktbsDeleteTrx(ctx, noti.inventoryPurchaseTrx!))
          .then((_) async {
        // delivery check
        if (!noti.isHomeDeliveryNeeded && noti.deliveryTrx != null) {
          await pktbsDeleteTrx(ctx, noti.deliveryTrx!).then((_) async {
            log.f(
                'order trxs delete with - 2 - no inventory, delivery trx anymore!');
            noti.clear();
            ctx.pop();
            EasyLoading.dismiss();
            await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
          });
        } else {
          log.f('order trxs delete with - 1 - no inventory trx anymore!');
          noti.clear();
          ctx.pop();
          EasyLoading.dismiss();
          await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
        }
      });
    } else {
      // delivery check
      if (!noti.isHomeDeliveryNeeded && noti.deliveryTrx != null) {
        await pktbsDeleteTrx(ctx, noti.deliveryTrx!).then((_) async {
          log.f('order trxs delete with - 1 - no delivery trx anymore!');
          noti.clear();
          ctx.pop();
          EasyLoading.dismiss();
          await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
        });
      } else {
        log.f('order trxs delete with - 0 - all trxs are needed!');
        noti.clear();
        ctx.pop();
        EasyLoading.dismiss();
        await showOrderSlipDownloadPopup(ctx, order, isUpdate: true);
      }
    }
  }
}
