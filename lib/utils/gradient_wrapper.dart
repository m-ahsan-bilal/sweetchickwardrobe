import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';

class GradientWrapper extends StatelessWidget {
  final Widget child;

  GradientWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [R.colors.softPink, R.colors.softlime],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
