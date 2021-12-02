import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final List<Color> colors;
  final List<Color> darkColors;
  final List<double> stops;
  final TextStyle textStyle;
  final double radius;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.colors = const [Color(0xfff44336), Color(0xffff9800)],
    this.darkColors = const [Color(0xff293545), Color(0xFF3B485F)],
    this.stops = const [0.0, 1.0],
    this.textStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    this.radius = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius),)),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                colors: Theme.of(context).brightness == Brightness.light ? colors : darkColors,
                stops: stops,
              )
          ),
          child: SizedBox(
              height: 35,
              child: Center(child: Text(buttonText, style: textStyle,))
          )
      ),
    );
  }
}
