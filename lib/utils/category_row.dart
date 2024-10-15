import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
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
              onTap: () {},
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

class CategoryColumn extends StatefulWidget {
  @override
  _CategoryColumnState createState() => _CategoryColumnState();
}

class _CategoryColumnState extends State<CategoryColumn> {
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

    return Column(
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
                horizontal: 2.0, vertical: isHovered ? 6.0 : 4.0),
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
              onTap: () {},
              splashColor: Colors.pink.shade100.withOpacity(0.5),
              highlightColor: Colors.purple.shade100,
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 8,
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
