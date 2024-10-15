import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/auth/auth_vm.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';
import 'package:sweetchickwardrobe/utils/gradient_wrapper.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';

import '../../../../resources/resources.dart';

import '../../vm/base_vm.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({Key? key}) : super(key: key);

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<AdminBaseVm, AuthVm>(builder: (context, baseVm, AuthVm, _) {
      return ResponsiveWidget.isLargeScreen(context)
          ? largeWidget(baseVm, AuthVm)
          : smallWidget(
              baseVm,
              AuthVm,
            );
    });
  }

  Widget largeWidget(AdminBaseVm baseVm, AuthVm AuthVm) {
    return GradientWrapper(
      child: Container(
        // color: R.colors.,
        child: Column(
          children: [
            userWidget(baseVm),
            Divider(color: R.colors.white, thickness: 1),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.sp),
                child: RawScrollbar(
                  thickness: 2,
                  thumbColor: R.colors.themePink,
                  radius: const Radius.circular(5),
                  thumbVisibility: false,
                  controller: scrollController,
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        sideBarContainer(
                          indexCount: 0,
                          icon: Icons.dashboard_rounded,
                          isIcon: true,
                          title: 'Dashboard',
                          baseVm: baseVm,
                        ),
                        sideBarContainer(
                          indexCount: 1,
                          icon: Icons.supervised_user_circle_rounded,
                          isIcon: true,
                          title: 'Users',
                          baseVm: baseVm,
                        ),
                        sideBarContainer(
                          indexCount: 2,
                          icon: Icons.shopping_cart_rounded,
                          isIcon: true,
                          title: 'Orders',
                          baseVm: baseVm,
                        ),
                        sideBarContainer(
                          indexCount: 3,
                          icon: Icons.category,
                          isIcon: true,
                          title: 'Categories',
                          baseVm: baseVm,
                        ),
                        sideBarContainer(
                          indexCount: 4,
                          icon: Icons.inventory_2_rounded,
                          isIcon: true,
                          title: 'Products',
                          baseVm: baseVm,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            logoutBtn(baseVm, AuthVm),
          ],
        ),
      ),
    );
  }

  Widget smallWidget(AdminBaseVm baseVm, AuthVm AuthVm) {
    return Container(
      color: R.colors.greyBlack,
      child: Column(
        children: [
          smallUserWidget(baseVm),
          Divider(
            color: R.colors.white,
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.sp),
              child: RawScrollbar(
                thickness: 2,
                thumbColor: R.colors.themePink,
                radius: const Radius.circular(5),
                thumbVisibility: false,
                controller: scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      smallSideBarContainer(
                        indexCount: 0,
                        icon: Icons.dashboard_rounded,
                        isIcon: true,
                        title: 'Dashboard',
                        baseVm: baseVm,
                      ),
                      smallSideBarContainer(
                        indexCount: 1,
                        icon: Icons.supervised_user_circle_rounded,
                        isIcon: true,
                        title: 'Users',
                        baseVm: baseVm,
                      ),
                      smallSideBarContainer(
                        indexCount: 2,
                        icon: Icons.shopping_cart_checkout_rounded,
                        isIcon: true,
                        title: 'Orders',
                        baseVm: baseVm,
                      ),
                      smallSideBarContainer(
                        indexCount: 3,
                        icon: Icons.category,
                        isIcon: true,
                        title: 'Categories',
                        baseVm: baseVm,
                      ),
                      smallSideBarContainer(
                        indexCount: 4,
                        icon: Icons.inventory_2_rounded,
                        isIcon: true,
                        title: 'Products',
                        baseVm: baseVm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          smallLogoutBtn(baseVm, AuthVm),
        ],
      ),
    );
  }

  Widget sideBarContainer({
    String? image,
    IconData? icon,
    bool? isIcon = false,
    required String title,
    required int indexCount,
    required AdminBaseVm baseVm,
  }) {
    return InkWell(
      onTap: () {
        baseVm.selectedIndex = indexCount;
        baseVm.pageController.jumpToPage(indexCount);
        baseVm.update();
      },
      child: Container(
        alignment: baseVm.isMini ? Alignment.center : Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        padding: EdgeInsets.all(3.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: baseVm.selectedIndex == indexCount ? R.colors.themePink : null,
        ),
        child: Row(
          mainAxisAlignment: baseVm.isMini == true ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.sp,
              height: 4.sp,
              child: isIcon == true
                  ? Icon(
                      icon,
                      color: baseVm.selectedIndex == indexCount ? R.colors.white : R.colors.sideIconColor,
                      size: 4.sp,
                    )
                  : Image.asset(
                      image ?? '',
                      color: baseVm.selectedIndex == indexCount ? R.colors.white : R.colors.lightGreyColor2,
                    ),
            ),
            if (!baseVm.isMini) SizedBox(width: 4.sp),
            if (!baseVm.isMini)
              Expanded(
                child: Text(
                  title,
                  style: R.textStyles.poppins(
                    color: baseVm.selectedIndex == indexCount ? R.colors.white : R.colors.lightGreyColor2,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget smallSideBarContainer({
    String? image,
    IconData? icon,
    bool? isIcon = false,
    required String title,
    required int indexCount,
    required AdminBaseVm baseVm,
  }) {
    return InkWell(
      onTap: () {
        baseVm.selectedIndex = indexCount;
        baseVm.pageController.jumpToPage(indexCount);
        baseVm.update();
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 2.h),
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: baseVm.selectedIndex == indexCount ? R.colors.themePink : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 5.sp,
                height: 5.sp,
                child: isIcon == true
                    ? Icon(
                        icon,
                        color: baseVm.selectedIndex == indexCount ? R.colors.white : R.colors.sideIconColor,
                        size: 5.sp,
                      )
                    : Image.asset(
                        image ?? '',
                        color: baseVm.selectedIndex == indexCount ? R.colors.white : R.colors.lightGreyColor2,
                      ),
              ),
            ],
          )),
    );
  }

  Widget userWidget(AdminBaseVm baseVm) {
    return Padding(
      padding: EdgeInsets.fromLTRB(baseVm.isMini ? 2.sp : 5.sp, 5.sp, baseVm.isMini ? 0 : 5.sp, 2.sp),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: EdgeInsets.only(right: baseVm.isMini ? 0 : 7),
            decoration: BoxDecoration(
              color: R.colors.lightYellowColor,
              border: Border.all(color: R.colors.white, width: 1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              R.images.logoTransparent,
              height: 5.h,
            ),
          ),
          if (!baseVm.isMini)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wardrobe",
                  style: R.textStyles.poppins(
                    color: R.colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Admin",
                  style: R.textStyles.poppins(
                    color: R.colors.hintTextColor,
                    fontSize: baseVm.isMini ? 10 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget smallUserWidget(AdminBaseVm baseVm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: R.colors.lightYellowColor,
          border: Border.all(color: R.colors.white, width: 1),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          R.images.logoTransparent,
          height: 5.h,
        ),
      ),
    );
  }

  Widget logoutBtn(AdminBaseVm baseVm, AuthVm AuthVm) {
    return baseVm.isMini
        ? Container(
            width: 100.w,
            height: 7.h,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: R.colors.themePink),
            child: IconButton(
              onPressed: () async {
                baseVm.selectedIndex = 0;
                await AuthVm.logout();
              },
              icon: Icon(
                Icons.power_settings_new,
                color: R.colors.white,
                size: 16,
              ),
            ),
          )
        : Container(
            width: 100.w,
            height: 7.h,
            margin: const EdgeInsets.all(10),
            child: AppButton(
              buttonTitle: "logout",
              onTap: () async {
                baseVm.selectedIndex = 0;
                await AuthVm.logout();
              },
            ),
          );
  }

  Widget smallLogoutBtn(AdminBaseVm baseVm, AuthVm AuthVm) {
    return Container(
      width: 100.w,
      height: 7.h,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: R.colors.themePink),
      child: IconButton(
        onPressed: () async {
          baseVm.selectedIndex = 0;
          await AuthVm.logout();
        },
        icon: Icon(
          Icons.power_settings_new,
          color: R.colors.white,
          size: 12,
        ),
      ),
    );
  }

  Widget titleText({
    required String title,
    required AdminBaseVm baseVm,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 3.sp, top: 1.sp, bottom: 1.sp, right: 1.sp),
      child: Text(
        '--${title.toUpperCase()}',
        style: R.textStyles.montserrat(
          color: R.colors.lightGrey,
          fontSize: baseVm.isMini ? 9 : 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
