import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../resources/resources.dart';
import '../view_model/order_vm.dart';
import 'widgets/order_data_grid_source.dart';
import 'widgets/order_grid.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      orderSource = OrderGridSource(isWebOrDesktop: true);
      Get.forceAppUpdate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderVM>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: R.colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.sp, vertical: 3.sp),
          decoration: BoxDecoration(
            color: R.colors.themePink,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              // filterStatusButton(name: 'all', index: 0, vm: vm),
              // filterStatusButton(name: 'active', index: 1, vm: vm),
              // filterStatusButton(name: 'block', index: 2, vm: vm),
              //     const Spacer(),
              //     SizedBox(
              //       height: 35,
              //       width: 52.sp,
              //       child: Center(child: searchField(vm)),
              //     ),
              //   ],
              // ),
              Flexible(
                child: vm.orderList.isEmpty
                    ? Center(
                        child: Text(
                          "Nothing Found",
                          style: R.textStyles.poppins(),
                        ),
                      )
                    : const OrderGrid(),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget searchField(OrderVM vm) {
    return TextFormField(
      focusNode: searchFocus,
      onTap: () {
        setState(() {});
      },
      onChanged: (s) {
        setState(() {});
        Get.forceAppUpdate();
      },
      style: R.textStyles.poppins(
        color: R.colors.offWhite,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: vm.searchController,
      decoration: R.decoration.fieldDecoration(
        hintText: "search",
        preIcon: Icon(Icons.search, size: 15, color: R.colors.hintTextColor),
        context: context,
      ),
    );
  }

  Widget filterStatusButton({required String name, required int index, required OrderVM vm}) {
    return InkWell(
      onTap: () {
        setState(() {
          vm.selectedIndex = index;
          debugPrint(vm.selectedIndex.toString());
          orderSource = OrderGridSource(isWebOrDesktop: true);
          Get.forceAppUpdate();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.only(top: 5, bottom: 12, right: 10),
        decoration: BoxDecoration(
          color: vm.selectedIndex == index ? R.colors.black : R.colors.hintTextColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          name,
          style: R.textStyles.poppins(fontSize: 15, color: R.colors.white),
        ),
      ),
    );
  }
}
