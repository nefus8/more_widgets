import 'package:flutter/material.dart';

/// Create a white rounded container that takes a child
class RoundedContainer extends StatelessWidget {
  final Widget? child;
  /// Takes a [Color], `white by default.
  final Color color;
  /// Takes a circularRadius that is `20` by default.
  final double circularRadius;
  /// Takes a margin that is `20` by default.
  final double margin;
  /// Takes a padding that is `20` by default.
  final double padding;

  const RoundedContainer({
    Key? key,
    this.child,
    this.color = Colors.white,
    this.circularRadius = 20,
    this.margin = 20,
    this.padding = 20
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(circularRadius),
      ),
      child: child,
    );
  }
}
