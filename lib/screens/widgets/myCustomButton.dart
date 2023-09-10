import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final String svgPath;
  final Color textColor;

  const MyCustomButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.svgPath,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: backgroundColor.withOpacity(0.8),
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              width: 40,
              height: 40,
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
