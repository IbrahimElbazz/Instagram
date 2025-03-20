import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.colorText,
  });
  final String text;
  final void Function()? onTap;
  final Color? color;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          Colors.pinkAccent.withValues(alpha: 0.1),
        ),
        backgroundColor: WidgetStateProperty.all(color),
        side: WidgetStateProperty.all(BorderSide(style: BorderStyle.none)),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 40.h,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
