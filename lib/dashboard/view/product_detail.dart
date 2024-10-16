// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sweetchickwardrobe/dashboard/model/cart_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/product_model.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedSize;
  int quantity = 1;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalWidgets.buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 450,
                                child: PageView(
                                  scrollDirection: Axis.horizontal,
                                  controller: pageController,
                                  children: List.generate(
                                    widget.product.imageUrl?.length ?? 0,
                                    (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Image.network(
                                          widget.product.imageUrl?[index] ?? "",
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, url, error) {
                                            return Icon(
                                              Icons.error,
                                              size: 55,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SmoothPageIndicator(
                                controller: pageController,
                                effect:
                                    WormEffect(dotColor: R.colors.themePink),
                                count: widget.product.imageUrl?.length ?? 0,
                                onDotClicked: (index) {
                                  pageController.jumpToPage(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product title
                              Text(widget.product.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8.0),

                              // Product description
                              Text(widget.product.description ?? "",
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 16.0),

                              // Product category
                              // Text("Category: ${widget.product.categoryId}",
                              //     style: const TextStyle(
                              //         fontSize: 16,
                              //         fontStyle: FontStyle.italic)),
                              const SizedBox(height: 16.0),

                              // Product price
                              Text("\$${widget.product.price}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16.0),

                              // Available sizes
                              const Text("Select Size:",
                                  style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 8.0),
                              if (widget.product.sizes != null &&
                                  (widget.product.sizes?.isNotEmpty ?? false))
                                Row(
                                  children: widget.product.sizes!.map((size) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSize = size;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        decoration: BoxDecoration(
                                          color: selectedSize == size
                                              ? Colors.blue
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Text(size,
                                            style: TextStyle(
                                                color: selectedSize == size
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              const SizedBox(height: 16.0),

                              // Quantity selection
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Quantity:",
                                      style: TextStyle(fontSize: 16)),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                      ),
                                      Text(quantity.toString(),
                                          style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          if (quantity <
                                              (widget.product.stockQuantity ??
                                                  0)) {
                                            setState(() {
                                              quantity++;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),

                              // Stock availability
                              // Text(
                              //     "Items left in stock: ${widget.product.stockQuantity}",
                              //     style: const TextStyle(
                              //         fontSize: 16, color: Colors.red)),
                              // const SizedBox(height: 16.0),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: IconAppButton(
                              //         iconData: Icons.favorite_border,
                              //         borderColor: R.colors.themePink,
                              //         textColor: R.colors.black,
                              //         isBorder: true,
                              //         onTap: () {
                              //           // Add to favourite functionality
                              //         },
                              //       ),
                              //     ),
                              //     SizedBox(width: 12),
                              //     Expanded(
                              //       child: IconAppButton(
                              //         iconData: Icons.share,
                              //         borderColor: R.colors.themePink,
                              //         textColor: R.colors.black,
                              //         isBorder: true,
                              //         onTap: () {
                              //           // Share functionality
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              SizedBox(
                                height: 10,
                              ),
                              // Add to Casirt button
                              SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                  buttonTitle: "Add to Cart",
                                  textColor: R.colors.black,
                                  borderColor: R.colors.themePink,
                                  isBorder: true,
                                  onTap: () {
                                    var vm = Provider.of<BaseVm>(context,
                                        listen: false);

                                    if ((selectedSize != null &&
                                        selectedSize != "")) {
                                      vm.cartItems.add(
                                        CartItem(
                                          product: widget.product,
                                          quantity: quantity,
                                          selectedSize: selectedSize,
                                        ),
                                      );
                                      ZBotToast.showToastSuccess(
                                          message:
                                              "Product ${widget.product.name} added to card.");
                                      debugPrint(
                                          vm.cartItems.length.toString());
                                      vm.update();
                                      setState(() {});
                                    } else {
                                      ZBotToast.showToastError(
                                          message: "Select Size to continue.");
                                    }
                                    debugPrint(vm.cartItems.length.toString());

                                    // if (selectedSize != null) {
                                    //   // Add to cart functionality
                                    // } else {
                                    //   // Show a message to select a size
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(const SnackBar(
                                    //           content: Text(
                                    //               "Please select a size")));
                                    // }
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GlobalWidgets.buildFooterWidget(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
