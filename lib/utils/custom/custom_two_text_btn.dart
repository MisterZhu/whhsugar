import 'package:flutter/material.dart';

class CustomTwoTextButton extends StatelessWidget {
  final String topText;
  final String bottomText;
  final TextStyle? topTextStyle;
  final TextStyle? bottomTextStyle;
  final VoidCallback? onPressed;

  const CustomTwoTextButton({
    required this.topText,
    required this.bottomText,
    this.topTextStyle,
    this.bottomTextStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            topText,
            style: topTextStyle ??
                TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
          ),
          SizedBox(height: 4), // 上下文字之间的间距
          Text(
            bottomText,
            style:
                bottomTextStyle ?? TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
