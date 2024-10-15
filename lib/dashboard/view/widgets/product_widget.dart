import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetchickwardrobe/dashboard/model/product_model.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel? model;
  const ProductWidget({super.key, this.model});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        // Navigate to Product Detail Screen
        context.go("/dashboard/product_detail", extra: widget.model);
      },
      child: Card(
        color: R.colors.white,
        child: Column(
          children: [
            if (widget.model?.imageUrl != null &&
                (widget.model?.imageUrl?.isNotEmpty ?? false))
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.model?.imageUrl?.first ?? "",
                  height: height * 0.16,
                  width: width * 0.16,
                  fit: BoxFit.cover,
                ),
              ),
            Container(
              width: width * 0.16,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.model?.name ?? "",
                      style: TextStyle(fontSize: width * 0.011)),
                  const SizedBox(width: 10),
                  Text("\$${widget.model?.price?.toStringAsFixed(2) ?? ""}",
                      style: TextStyle(
                          fontSize: width * 0.01, color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
