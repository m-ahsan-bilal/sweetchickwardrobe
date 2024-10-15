import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/orders/view_model/order_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/users/view_model/user_vm.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';
import '../../../../../resources/resources.dart';
import '../../../vm/base_vm.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  List<String> statTitleList = ['Total Users', 'Total Orders'];

  @override
  Widget build(BuildContext context) {
    return Consumer2<AdminBaseVm, UserVM>(builder: (context, vmBase, uservm, _) {
      return Scaffold(
        backgroundColor: R.colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                statsWidget(
                  vm: vmBase,
                  index: 1,
                  gradient: R.colors.appGradient3,
                  icon: Icons.supervised_user_circle_sharp,
                  title: statTitleList[0],
                  stats: uservm.userList.length,
                ),
                statsWidget(
                  vm: vmBase,
                  index: 2,
                  gradient: R.colors.appGradient2,
                  icon: Icons.shopping_cart_rounded,
                  title: statTitleList[1],
                  stats: context.watch<OrderVM>().orderList.length,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget statsWidget({
    required IconData icon,
    required int stats,
    required String title,
    required Gradient gradient,
    required int index,
    required AdminBaseVm vm,
  }) {
    return InkWell(
      onTap: () {
        vm.selectedIndex = index;
        vm.pageController.jumpToPage(index);
        vm.update();
      },
      child: Container(
        // constraints: BoxConstraints(minWidth: 10.w, maxWidth: 14.w, maxHeight: 12.h, minHeight: 10.h),
        constraints: BoxConstraints(minWidth: ResponsiveWidget.isLargeScreen(context) ? 250 : 200, maxWidth: ResponsiveWidget.isLargeScreen(context) ? 251 : 201),
        decoration: BoxDecoration(color: R.colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(
            color: R.colors.shadowColor.withOpacity(0.16),
            offset: const Offset(0, 9),
            blurRadius: 25,
          ),
        ]),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                color: R.colors.white,
                size: 5.h,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: R.textStyles.poppins(
                      fontSize: 13,
                      color: R.colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ResponsiveWidget.isLargeScreen(context) ? 10 : 5),
                  Text(
                    stats.toString(),
                    style: R.textStyles.montserrat(
                      fontSize: 15,
                      color: R.colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
