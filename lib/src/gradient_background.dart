import 'package:flutter/material.dart';

/// This widget displays a [LinearGradient] as background of an app.
class GradientBackground extends StatelessWidget {
  /// The child of the widget
  final Widget child;

  /// The list of colors the [LinearGradient] should display
  final List<Color> colors;
  final List<Color> darkColors;
  final List<double> stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  /// Whether or not the color of the gradient should change when turning the
  /// device into dark mode.

  const GradientBackground({
    Key? key,
    required this.child,
    this.colors = const [Color(0xffff9800), Color(0xfff44336)],
    this.darkColors = const [Color(0xff13191f), Color(0xff262f3c)],
    this.stops = const [0.2, 0.8],
    this.begin = FractionalOffset.topLeft,
    this.end = FractionalOffset.bottomRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: child,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: Theme.of(context).brightness == Brightness.light ? colors : darkColors,
            stops: stops,
            begin: begin,
            end: end,
          )),
        ),
      ),
    );
  }
}
