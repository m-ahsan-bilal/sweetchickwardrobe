import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../resources/resources.dart';
import '../view_model/user_vm.dart';
import 'widgets/user_data_grid_source.dart';
import 'widgets/user_grid.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Fetch users when the view is initialized
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      userDataSource = UserModelGridSource(isWebOrDesktop: true);

      Provider.of<UserVM>(context, listen: false).getUsers();
      Get.forceAppUpdate();
    });
  }
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     userDataSource = UserModelGridSource(isWebOrDesktop: true);
  //     Get.forceAppUpdate();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserVM>(builder: (context, vm, _) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // filterStatusButton(name: 'all', index: 0, vm: vm),
                  // filterStatusButton(name: 'active', index: 1, vm: vm),
                  // filterStatusButton(name: 'block', index: 2, vm: vm),
                  const Spacer(),
                  SizedBox(
                    height: 35,
                    width: 52.sp,
                    child: Center(child: searchField(vm)),
                  ),
                ],
              ),
              Flexible(
                child: vm.userList.isEmpty
                    ? Center(
                        child: Text(
                          "Nothing Found",
                          style: R.textStyles.poppins(),
                        ),
                      )
                    : const UserGrid(),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget searchField(UserVM vm) {
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

  Widget filterStatusButton(
      {required String name, required int index, required UserVM vm}) {
    return InkWell(
      onTap: () {
        setState(() {
          vm.selectedIndex = index;
          debugPrint(vm.selectedIndex.toString());
          userDataSource = UserModelGridSource(isWebOrDesktop: true);
          Get.forceAppUpdate();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.only(top: 5, bottom: 12, right: 10),
        decoration: BoxDecoration(
          color: vm.selectedIndex == index
              ? R.colors.black
              : R.colors.hintTextColor,
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
