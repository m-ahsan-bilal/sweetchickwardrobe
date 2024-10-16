import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';

class CategoryRow extends StatefulWidget {
  late final CategoryModel? model;
  @override
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  String _hoveredCategory = "";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final categories = [
      "Apparels",
      "Bags",
      "Shoes",
      "Accessories",
      "New Arrivals",
      "Sale"
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories.map((category) {
        final isHovered = _hoveredCategory == category;
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _hoveredCategory = category;
            });
          },
          onExit: (_) {
            setState(() {
              _hoveredCategory = "";
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
                horizontal: 2.0, vertical: isHovered ? 12.0 : 8.0),
            decoration: BoxDecoration(
              color: isHovered
                  ? Colors.pink.shade200.withOpacity(0.6) // Soft hover color
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isHovered
                  ? [BoxShadow(blurRadius: 6, color: Colors.pink.shade100)]
                  : [],
            ),
            child: InkWell(
              onTap: () {
                context.go('/shop_view', extra: widget.model);
              },
              splashColor: Colors.pink.shade100.withOpacity(0.5),
              highlightColor: Colors.purple.shade100,
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isHovered ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CategoryNameWidget extends StatefulWidget {
  final CategoryModel model;
  const CategoryNameWidget({Key? key, required this.model}) : super(key: key);

  @override
  _CategoryNameWidgetState createState() => _CategoryNameWidgetState();
}

class _CategoryNameWidgetState extends State<CategoryNameWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          context.go('/shop_view', extra: widget.model);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.pink.shade100 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isHovered
                ? [BoxShadow(blurRadius: 4, color: Colors.pink.shade200)]
                : [],
          ),
          child: Text(
            widget.model.categoryName ?? "Category",
            style: R.textStyles.poppins(
                context: context,
                fontSize: 12,
                // fontWeight: FontWeight.w500,
                color: _isHovered ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }
}

Widget buildCategoriesColumn(BuildContext context) {
  // fetching categories
  final categories = context.read<BaseVm>().categories;

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: List.generate(
        categories.take(5).length,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CategoryNameWidget(model: categories[index]),
          );
        },
      ),
    ),
  );
}

// row build categories
Widget buildCategoriesRow(BuildContext context) {
  // fetching categories
  final categories = context.read<BaseVm>().categories;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    // padding: const EdgeInsets.all(.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        categories.length,
        // categories.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CategoryNameWidget(model: categories[index]),
          );
        },
      ),
    ),
  );
}
