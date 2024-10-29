import 'package:flutter/material.dart';
import 'package:monitoring/Constants/constants.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const CustomTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
        fontFamily: 'heading',
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;

  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.9,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: subHeadingText,
          color: Colors.black,
          fontFamily: 'SubHeading',
        ),
      ),
    );
  }
}

class CircularElevatedButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const CircularElevatedButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final double height;
  final Color color;
  final Widget? child;

  const CustomContainer({
    super.key,
    required this.height,
    required this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: height,
      color: color,
      child: child,
    );
  }
}

class CustomWRectangleButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onPressed;

  const CustomWRectangleButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Small curve
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }
}

int _divisions = 5;

Color getLineColor(double sliderValue, double position) {
  return sliderValue >= position ? buttonColor : lines;
}

class ThermometerLine extends StatelessWidget {
  final double sliderValue;

  const ThermometerLine(this.sliderValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_divisions, (index) {
        double position = (_divisions - index) * (100 / _divisions);
        Color lineColor = getLineColor(sliderValue, position);
        return Container(
          width: 32,
          height: 3.5,
          color: lineColor,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
        );
      }),
    );
  }
}
