import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';

class CategoryWidget extends StatefulWidget {
  final CategoryModel? model;
  const CategoryWidget({super.key, this.model});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        context.go('/shop_view', extra: widget.model);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ShopView(selectedCategory: widget.model)));
        // Navigate to category-specific product listing screen
      },
      child: Card(
        color: R.colors.white,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.model?.imageUrl ?? "",
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.model?.categoryName ?? "",
                  style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
