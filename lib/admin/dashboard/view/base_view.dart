import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/categories/view/category_view.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/categories/view_model/category_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/orders/view/order_view.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/orders/view_model/order_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/products/view/product_view.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/products/view_model/product_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/users/view_model/user_vm.dart';
import 'package:sweetchickwardrobe/utils/gradient_wrapper.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';

import '../../../resources/resources.dart';
import '../pages/dashboard/view/dashboard_home.dart';
import '../pages/users/view/user_view.dart';
import '../vm/base_vm.dart';
import 'widgets/side_bar_widget.dart';

class AdminDashboard extends StatefulWidget {
  static String route = '/AdminDashboard';
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var vm = Provider.of<UserVM>(context, listen: false);
      var ovm = Provider.of<OrderVM>(context, listen: false);
      var cvm = Provider.of<CategoryVM>(context, listen: false);
      var pvm = Provider.of<ProductVM>(context, listen: false);
      await vm.getUsers();
      await ovm.getOrders();
      await cvm.getCategories();
      await pvm.getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminBaseVm>(builder: (context, baseVm, _) {
      return Scaffold(
        backgroundColor: R.colors.transparent,
        body: ResponsiveWidget(
          largeScreen: largeScreen(baseVm),
          mediumScreen: smallScreen(baseVm),
          smallScreen: smallScreen(baseVm),
        ),
      );
    });
  }

  Widget largeScreen(AdminBaseVm baseVm) {
    return Row(
      children: [
        Expanded(flex: baseVm.isMini ? 1 : 2, child: const SideBarWidget()),
        Expanded(
          flex: baseVm.isMini ? 15 : 8,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: topBar(baseVm),
              ),
              Expanded(
                flex: 18,
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: PageView(
                    controller: baseVm.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DashboardHome(),
                      UserView(),
                      OrderView(),
                      CategoryView(),
                      ProductView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget smallScreen(AdminBaseVm baseVm) {
    return Row(
      children: [
        const Expanded(flex: 1, child: SideBarWidget()),
        Expanded(
          flex: 15,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: topBarSmall(baseVm),
              ),
              Expanded(
                flex: 18,
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: PageView(
                    controller: baseVm.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DashboardHome(), //0
                      // Users
                      UserView(),
                      OrderView(),
                      CategoryView(),
                      ProductView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget topBar(AdminBaseVm vm) {
    return GradientWrapper(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5.sp),
                InkWell(
                  onTap: () {
                    vm.isMini = !vm.isMini;
                    vm.update();
                  },
                  child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.menu,
                        color: R.colors.softWhite,
                        size: 30,
                      )),
                ),
              ],
            ),
            Image.asset(
              R.images.logoTransparent, //logo
              height: 10.h,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget topBarSmall(AdminBaseVm vm) {
    return Container(
      color: R.colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            R.images.logoTransparent, //logo
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
