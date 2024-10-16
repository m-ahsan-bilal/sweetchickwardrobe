import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/categories/view_model/category_vm.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';

class ProductDialog extends StatefulWidget {
  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _colorController = TextEditingController();
  final _sizesController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  final _discountAvailableController = TextEditingController();
  final _discountPercentageController = TextEditingController();
  final _additionalInfoBrandController = TextEditingController();
  final _additionalInfoMaterialController = TextEditingController();
  final _ratingAverageController = TextEditingController();
  final _ratingReviewsController = TextEditingController();
  final _shippingEstimatedDeliveryController = TextEditingController();
  final _shippingFreeShippingController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var vm = Provider.of<CategoryVM>(context, listen: false);
      await vm.getCategories();
      Get.forceAppUpdate();
    });
    super.initState();
  }

  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _categoryIdController,
                decoration: InputDecoration(labelText: 'Category ID'),
              ),
              // context.read<CategoryVM>().categoryList
              DropdownButtonFormField<CategoryModel>(
                value:
                    _selectedCategory, // You should initialize this with a default value
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                items: context.read<CategoryVM>().categoryList.map((category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category, // Assuming category has an 'id' field
                    child: Text(category.categoryName ??
                        ""), // Assuming category has a 'name' field
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });

                  // Save the selected category
                  _categoryIdController.text =
                      _selectedCategory?.categoryId ?? "";
                },
              ),
              // TextField(
              //   controller: _colorController,
              //   decoration: InputDecoration(labelText: 'Color'),
              // ),

              TextField(
                controller: _sizesController,
                decoration:
                    InputDecoration(labelText: 'Sizes (comma-separated)'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration:
                    InputDecoration(labelText: 'Image URL (comma-separated)'),
              ),
              // TextField(
              //   controller: _stockQuantityController,
              //   decoration: InputDecoration(labelText: 'Stock Quantity'),
              //   keyboardType: TextInputType.number,
              // ),
              // TextField(
              //   controller: _discountAvailableController,
              //   decoration: InputDecoration(
              //       labelText: 'Discount Available (true/false)'),
              // ),
              // TextField(
              //   controller: _discountPercentageController,
              //   decoration: InputDecoration(labelText: 'Discount Percentage'),
              //   keyboardType: TextInputType.number,
              // ),
              // TextField(
              //   controller: _additionalInfoBrandController,
              //   decoration:
              //       InputDecoration(labelText: 'Additional Info - Brand'),
              // ),
              // TextField(
              //   controller: _additionalInfoMaterialController,
              //   decoration:
              //       InputDecoration(labelText: 'Additional Info - Material'),
              // ),
              // TextField(
              //   controller: _ratingAverageController,
              //   decoration: InputDecoration(labelText: 'Rating Average'),
              //   keyboardType: TextInputType.numberWithOptions(decimal: true),
              // ),
              // TextField(
              //   controller: _ratingReviewsController,
              //   decoration: InputDecoration(labelText: 'Rating Reviews'),
              //   keyboardType: TextInputType.number,
              // ),
              // TextField(
              //   controller: _shippingEstimatedDeliveryController,
              //   decoration:
              //       InputDecoration(labelText: 'Shipping Estimated Delivery'),
              // ),
              // TextField(
              //   controller: _shippingFreeShippingController,
              //   decoration:
              //       InputDecoration(labelText: 'Free Shipping (true/false)'),
              // ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text;
            final description = _descriptionController.text;
            final price = double.tryParse(_priceController.text) ?? 0.0;
            final categoryId = _categoryIdController.text;
            final color = _colorController.text;
            final sizes =
                _sizesController.text.split(',').map((s) => s.trim()).toList();
            final imageUrl = _imageUrlController.text
                .split(',')
                .map((s) => s.trim())
                .toList();
            final stockQuantity =
                int.tryParse(_stockQuantityController.text) ?? 0;
            final discountAvailable =
                _discountAvailableController.text.toLowerCase() == 'true';
            final discountPercentage =
                int.tryParse(_discountPercentageController.text) ?? 0;
            final additionalInfoBrand = _additionalInfoBrandController.text;
            final additionalInfoMaterial =
                _additionalInfoMaterialController.text;
            final ratingAverage =
                double.tryParse(_ratingAverageController.text) ?? 0.0;
            final ratingReviews =
                int.tryParse(_ratingReviewsController.text) ?? 0;
            final shippingEstimatedDelivery =
                _shippingEstimatedDeliveryController.text;
            final shippingFreeShipping =
                _shippingFreeShippingController.text.toLowerCase() == 'true';

            if (name.isNotEmpty &&
                price > 0 &&
                categoryId.isNotEmpty &&
                imageUrl.isNotEmpty &&
                sizes.isNotEmpty) {
              Navigator.of(context).pop({
                'name': name,
                'description': description,
                'price': price,
                'category_id': categoryId,
                'color': color,
                'sizes': sizes,
                'image_url': imageUrl,
                'stock_quantity': stockQuantity,
                'discount': {
                  'available': discountAvailable,
                  'percentage': discountPercentage,
                },
                'additional_info': {
                  'brand': additionalInfoBrand,
                  'material': additionalInfoMaterial,
                },
                'rating': {
                  'average': ratingAverage,
                  'reviews': ratingReviews,
                },
                'shipping': {
                  'estimated_delivery': shippingEstimatedDelivery,
                  'free_shipping': shippingFreeShipping,
                },
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all required fields')),
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
