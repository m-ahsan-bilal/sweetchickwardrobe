import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/orders/view/widgets/order_dialog.dart';

import 'package:sweetchickwardrobe/constants/enums.dart';
import 'package:sweetchickwardrobe/constants/firebase_collections.dart';
import 'package:sweetchickwardrobe/routes/app_routes.dart';
import 'package:sweetchickwardrobe/utils/global_function.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../../../dashboard/model/order-model.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../utils/syncfusion_data_grid/sample_model.dart';
import '../../view_model/order_vm.dart';
import 'order_grid.dart';

/// Set order's data collection to data grid source.
class OrderGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  OrderGridSource({this.model, required this.isWebOrDesktop}) {
    var vm =
        Provider.of<OrderVM>(navigatorKey.currentState!.context, listen: false);
    tickets = getLists();

    buildDataGridRows(vm);
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;

  /// Instance of SampleModel.
  final SampleModel? model;

  /// Instance of an order.
  List<OrderModel> tickets = <OrderModel>[];

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Building DataGridRows
  void buildDataGridRows(OrderVM vm) {
    if (vm.selectedIndex == 0) {
      dataGridRows = tickets
          .where((element) => element.orderId
              .toString()
              .isCaseInsensitiveContains(vm.searchController.text))
          .toList()
          .map<DataGridRow>((OrderModel model) {
        return DataGridRow(cells: <DataGridCell>[
          DataGridCell<OrderModel>(columnName: 'sr_no', value: model),
          DataGridCell<OrderModel>(columnName: 'name', value: model),
          DataGridCell<OrderModel>(columnName: 'email_caps', value: model),
          DataGridCell<OrderModel>(columnName: 'created_at', value: model),
          DataGridCell<OrderModel>(columnName: 'status', value: model),
          DataGridCell<OrderModel>(columnName: 'action', value: model),
        ]);
      }).toList();
    } else {
      dataGridRows = tickets
          .where((element) => element.orderId
              .toString()
              .isCaseInsensitiveContains(vm.searchController.text))
          .toList()
          .map<DataGridRow>((OrderModel model) {
        return DataGridRow(cells: <DataGridCell>[
          DataGridCell<OrderModel>(columnName: 'sr_no', value: model),
          DataGridCell<OrderModel>(columnName: 'name', value: model),
          DataGridCell<OrderModel>(columnName: 'email_caps', value: model),
          DataGridCell<OrderModel>(columnName: 'created_at', value: model),
          DataGridCell<OrderModel>(columnName: 'status', value: model),
          DataGridCell<OrderModel>(columnName: 'action', value: model),
        ]);
      }).toList();
    }
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = R.colors.themePink;
    // if (model != null && (rowIndex % 2) == 0) {
    //   backgroundColor = model!.backgroundColor.withOpacity(0.07);
    // }
    if (isWebOrDesktop) {
      OrderModel model = row.getCells()[0].value;
      DateTime now = DateTime.now();
      var vm = Provider.of<OrderVM>(navigatorKey.currentState!.context,
          listen: false);
      return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
        /// Serial Number
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            "${rowIndex + 1}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style:
                R.textStyles.poppins(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),

        /// Name
        InkWell(
          onTap: () {
            showDialog(
              context: navigatorKey.currentState!.context,
              builder: (context) {
                return OrderDialog(order: model);
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              model.userId ?? "",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: R.textStyles.poppins(
                  fontSize: 12,
                  color: R.colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),

        /// UserName
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            model.paymentMethod?.type ?? "",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: R.textStyles.poppins(
                fontSize: 12,
                color: R.colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),

        /// Created At
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            GlobalFunction.getDateTime(model.orderDate?.toDate() ?? now),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: R.textStyles.poppins(
                fontSize: 12,
                color: R.colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),

        /// Status
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 2.sp, vertical: 1.sp),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: model.orderStatus == UserStatus.ACTIVE.index ? R.colors.greenButton : R.colors.pinkRed,
              // color: model.orderStatus == UserStatus.ACTIVE.index ? R.colors.greenButton : R.colors.pinkRed,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              model.orderStatus ?? "",
              style: R.textStyles.poppins(fontSize: 11),
            ),
          ),
        ),

        /// Action
        PopupMenuButton(
          offset: const Offset(-40, 45),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            height: 6.sp,
            width: 6.sp,
            decoration: BoxDecoration(
              color: R.colors.offWhite,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.more_horiz,
              color: R.colors.black,
            ),
          ),
          onSelected: (val) async {
            ZBotToast.loadingShow();
            switch (val) {
              case 0:
                // model.status=UserStatusEnum.active;
                // await updateStatus(model.id ?? "", UserStatus.ACTIVE.index);
                break;
              case 1:
                // model.status=UserStatusEnum.blocked;
                // await updateStatus(model.id ?? "", UserStatus.BLOCKED.index);
                break;
            }
            await vm.getOrders();
            orderSource = OrderGridSource(isWebOrDesktop: isWebOrDesktop);
            Get.forceAppUpdate();
          },
          itemBuilder: (context) => [
            if (model.orderStatus != UserStatus.ACTIVE.index)
              GlobalWidgets.popupMenuItem(0, "Active")
            else
              GlobalWidgets.popupMenuItem(
                1,
                "Block",
              ),
          ],
        ),
      ]);
    } else {
      Widget buildWidget({
        AlignmentGeometry alignment = Alignment.center,
        EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
        TextOverflow textOverflow = TextOverflow.ellipsis,
        required Object value,
      }) {
        return Container(
          padding: padding,
          alignment: alignment,
          child: Text(
            value.toString(),
            overflow: textOverflow,
          ),
        );
      }

      return DataGridRowAdapter(
          color: backgroundColor,
          cells: row.getCells().map<Widget>((DataGridCell dataCell) {
            if (dataCell.columnName == 'id' ||
                dataCell.columnName == 'UserId') {
              return buildWidget(
                  alignment: Alignment.centerRight, value: dataCell.value!);
            } else {
              return buildWidget(value: dataCell.value!);
            }
          }).toList(growable: false));
    }
  }

  @override
  Future<void> handleLoadMoreRows() async {
    var vm =
        Provider.of<OrderVM>(navigatorKey.currentState!.context, listen: false);
    await Future<void>.delayed(const Duration(seconds: 5));
    tickets = getLists();
    buildDataGridRows(vm);
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    var vm =
        Provider.of<OrderVM>(navigatorKey.currentState!.context, listen: false);
    await Future<void>.delayed(const Duration(seconds: 5));
    tickets = getLists();
    buildDataGridRows(vm);
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      );
    }

    if (summaryRow.showSummaryInRow) {
      return buildCell(
          summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
    } else if (summaryValue.isNotEmpty) {
      if (summaryColumn!.columnName == 'freight') {
        summaryValue = double.parse(summaryValue).toStringAsFixed(2);
      }

      summaryValue =
          'Sum: ${NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: r'$').format(double.parse(summaryValue))}';

      return buildCell(
          summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
    }
    return null;
  }

  List<OrderModel> getLists() {
    return Provider.of<OrderVM>(navigatorKey.currentState!.context,
            listen: false)
        .orderList;
  }

  Future<void> updateStatus(String id, int status) async {
    try {
      await FBCollections.users.doc(id).update({"status": status});
    } catch (e) {
      debugPrintStack();
    }
  }
}
