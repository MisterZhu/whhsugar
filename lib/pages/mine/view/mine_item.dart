import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar/su_export_comment.dart';

class MineItem extends StatelessWidget {
  final String? imagePath;
  final String? text;
  final Function()? onTap;

  MineItem({super.key, this.imagePath, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
          height: 56.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: SCColors.color_1C1D1F),
          child: Row(
            children: [
              Image.asset(
                imagePath ?? '',
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                text ?? '',
                style: TextStyle(
                    fontSize: 16.sp, color: SUColorSingleton().textColor),
              ),
              Spacer(),
              Image.asset(
                Assets.commonRightArrow,
                width: 8.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
