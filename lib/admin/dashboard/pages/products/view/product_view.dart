import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';
import '../../../../../dashboard/model/product_model.dart';
import '../../../../../resources/resources.dart';
import '../view_model/product_vm.dart';
import 'widgets/product_data_grid_source.dart';
import 'widgets/product_dialog.dart';
import 'widgets/product_grid.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      productDataSource = ProductGridSource(isWebOrDesktop: true);
      Get.forceAppUpdate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductVM>(builder: (context, vm, _) {
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
                        final result = await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (context) => ProductDialog(),
                        );

                        if (result != null) {
                          final name = result['name'];
                          final description = result['description'];
                          final price = result['price'];
                          final categoryId = result['category_id'];
                          final color = result['color'];
                          final sizes = List<String>.from(result['sizes']);
                          final imageUrl = List<String>.from(result['image_url']);
                          final stockQuantity = result['stock_quantity'];
                          final discount = Discount(
                            available: result['discount']['available'],
                            percentage: result['discount']['percentage'],
                          );
                          final additionalInfo = AdditionalInfo(
                            brand: result['additional_info']['brand'],
                            material: result['additional_info']['material'],
                          );
                          final rating = Rating(
                            average: result['rating']['average'],
                            reviews: result['rating']['reviews'],
                          );
                          final shipping = Shipping(
                            estimatedDelivery: result['shipping']['estimated_delivery'],
                            freeShipping: result['shipping']['free_shipping'],
                          );

                          await vm.addProductToFirestore(
                            name: name,
                            description: description,
                            price: price,
                            categoryId: categoryId,
                            color: color,
                            sizes: sizes,
                            imageUrl: imageUrl,
                            stockQuantity: stockQuantity,
                            discount: discount,
                            additionalInfo: additionalInfo,
                            rating: rating,
                            shipping: shipping,
                          );
                        }
                        await vm.getProducts();
                        productDataSource = ProductGridSource(isWebOrDesktop: true);
                        setState(() {});
                        Get.forceAppUpdate();
                        ZBotToast.loadingClose();
                      },
                      icon: Row(
                        children: [
                          Icon(Icons.add_box_rounded),
                          Text("Add Product"),
                        ],
                      ))
                ],
              ),
              h1,
              Flexible(
                child: vm.productList.isEmpty
                    ? Center(
                        child: Text(
                          "Nothing Found",
                          style: R.textStyles.poppins(),
                        ),
                      )
                    : const ProductGrid(),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget searchField(ProductVM vm) {
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

  Widget filterStatusButton({required String name, required int index, required ProductVM vm}) {
    return InkWell(
      onTap: () {
        setState(() {
          vm.selectedIndex = index;
          debugPrint(vm.selectedIndex.toString());
          productDataSource = ProductGridSource(isWebOrDesktop: true);
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
