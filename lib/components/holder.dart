import 'package:calculator/components/seed_color.dart';
import 'package:flutter/material.dart';

class Holder extends StatelessWidget {
  const Holder({
    super.key, required this.child_
  });
final child_;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: child_,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: ColorScheme.fromSeed(seedColor: seed).onSurface),
          color: ColorScheme.fromSeed(seedColor: seed).onBackground),
    );
  }
}
