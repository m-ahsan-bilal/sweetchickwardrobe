import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';
import '../../../../../resources/resources.dart';
import '../view_model/category_vm.dart';
import 'widgets/category_data_grid_source.dart';
import 'widgets/category_dialog.dart';
import 'widgets/category_grid.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      categoryDataSource = CategoryGridSource(isWebOrDesktop: true);
      Get.forceAppUpdate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryVM>(builder: (context, vm, _) {
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(R.colors.white)),
                      onPressed: () async {
                        // await vm.addCategory();
                        final result = await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (context) => CategoryDialog(),
                        );

                        if (result != null) {
                          final imageUrl = result['image_url']!;
                          final categoryName = result['category_name']!;
                          final description = result['description'] ?? '';
                          ZBotToast.loadingShow();

                          await vm.addCategoryToFirestore(
                            imageUrl: imageUrl,
                            categoryName: categoryName,
                            description: description,
                          );
                          await vm.getCategories();
                          categoryDataSource = CategoryGridSource(isWebOrDesktop: true);
                          setState(() {});
                          Get.forceAppUpdate();
                          ZBotToast.loadingClose();
                        }
                      },
                      icon: Row(
                        children: [
                          Icon(Icons.add_box_rounded),
                          Text("Add Category"),
                        ],
                      ))
                ],
              ),
              h1,
              Flexible(
                child: vm.categoryList.isEmpty
                    ? Center(
                        child: Text(
                          "Nothing Found",
                          style: R.textStyles.poppins(),
                        ),
                      )
                    : const CategoryGrid(),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget searchField(CategoryVM vm) {
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

  Widget filterStatusButton({required String name, required int index, required CategoryVM vm}) {
    return InkWell(
      onTap: () {
        setState(() {
          vm.selectedIndex = index;
          debugPrint(vm.selectedIndex.toString());
          categoryDataSource = CategoryGridSource(isWebOrDesktop: true);
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
