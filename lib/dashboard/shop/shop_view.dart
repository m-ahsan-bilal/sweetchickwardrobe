// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';

import 'package:sweetchickwardrobe/dashboard/shop/rating_widget.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/product_widget.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class ShopView extends StatefulWidget {
  final CategoryModel? selectedCategory;
  ShopView({super.key, this.selectedCategory});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  // List<ProductModel> filteredProducts = [];
  CategoryModel? categoryModel;

  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      categoryModel = widget.selectedCategory;
      await fetchAndFilterProducts();
      setState(() {});
    });
  }

  Future<void> fetchAndFilterProducts() async {
    ZBotToast.loadingShow();
    var vm = Provider.of<BaseVm>(context, listen: false);
    if (/* categoryModel == null && */ vm.categories.isEmpty) {
      await vm.fetchCategories();
    }
    if (vm.products.isEmpty && categoryModel != null) {
      await vm.fetchProducts();
    }
    if (categoryModel != null) {
      vm.filterProductsByCategory(categoryModel!);
    }
    ZBotToast.loadingClose();
  }

  // Future<void> fetchAndFilterProducts() async {
  //   var vm = Provider.of<BaseVm>(context, listen: false);
  //   await vm.fetchProducts(); // Fetch products from Firestore
  //   filterProductsByCategory(vm.products); // Filter products based on category
  // }
  // void filterProductsByCategory(List<ProductModel> products) {
  //   setState(() {
  //     filteredProducts = products
  //         .where((product) => product.categoryId == categoryModel?.categoryId)
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<BaseVm>(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalWidgets.buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryList(),
                  SizedBox(height: 10),
                  _buildCategoryDetails(),
                  if (vm.filteredProducts.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        vm.filteredProducts.length,
                        (index) {
                          return ProductWidget(
                              model: vm.filteredProducts[index]);
                        },
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: Text("No products available in this category."),
                    ),
                  ],
                  SizedBox(height: 10),
                  _buildCustomerReviews(),
                  SizedBox(height: 10),
                ],
              ),
            ),
            GlobalWidgets.buildFooterWidget(context),
          ],
        ),
      ),
    );
  }

  // Build category list with hover effect
  // Build category list with hover effect
  Widget _buildCategoryList() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: context.read<BaseVm>().categories.length,
        itemBuilder: (context, index) {
          final category = context.read<BaseVm>().categories[index];
          final isSelected = category.categoryId == categoryModel?.categoryId;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() async {
                  categoryModel = category;

                  if (categoryModel != null) {
                    await fetchAndFilterProducts();
                    // context
                    //     .read<BaseVm>()
                    //     .filterProductsByCategory(categoryModel!);
                  }
                });
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 2,
                    color:
                        isSelected ? R.colors.themePink : R.colors.transparent,
                  ),
                  // image: DecorationImage(
                  //   image: NetworkImage(category.imageUrl ?? ""),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Text(
                  category.categoryName ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                        color: R.colors.white.withOpacity(.75),
                        offset: const Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: R.colors.white.withOpacity(.75),
                        offset: const Offset(-2, -2),
                        spreadRadius: 2,
                        blurRadius: 10,
                      )
                    ],
                    color: R.colors.black, // Highlight selected category
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildCategoryList() {
  //   return Container(
  //     height: 50,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: context.read<BaseVm>().categories.length,
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           onTap: () {
  //             setState(() {
  //               categoryModel = context.read<BaseVm>().categories[index];
  //               fetchAndFilterProducts();
  //             });
  //           },
  //           child: MouseRegion(
  //             cursor: SystemMouseCursors.click,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Text(
  //                 context.read<BaseVm>().categories[index].categoryName ?? "",
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w600,
  //                   decoration: TextDecoration.none,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Build category details section
  Widget _buildCategoryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryModel?.categoryName ?? "",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Text(
          categoryModel?.description ?? "",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Build customer reviews section
  Widget _buildCustomerReviews() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              'Let customers speak for us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: context.read<BaseVm>().ratings.length,
              itemBuilder: (context, index, realIndex) {
                return ReviewWidget(
                    rating: context.read<BaseVm>().ratings[index]);
              },
              options: CarouselOptions(
                height: 140,
                viewportFraction: 0.4,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _carouselController.previousPage();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    _carouselController.nextPage();
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ));
  }
}
