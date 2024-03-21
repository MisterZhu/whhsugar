import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Buttons {
  /*
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
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
          ),
          SizedBox(height: 4.w), // 上下文字之间的间距
          Text(
            bottomText,
            style:
                bottomTextStyle ?? TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
  * */

  static Widget doubleText({
    // required VoidCallback? onPressed,
    required String topText,
    required String bottomText,
    VoidCallback? onPressed,
    TextStyle? topTextStyle,
    TextStyle? bottomTextStyle,
  }) {
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
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
          ),
          SizedBox(height: 4.w), // 上下文字之间的间距
          Text(
            bottomText,
            style: bottomTextStyle ??
                TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  static Widget wrapFilled({
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Color? backgroundColor,
  }) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: borderRadius)
            : null,
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget wrapText({
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsets? padding,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget wrapOutlined({
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsets? padding,
    OutlinedBorder? shape,
    BorderSide? side,
    Color? backgroundColor,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        shape: shape,
        side: side,
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
