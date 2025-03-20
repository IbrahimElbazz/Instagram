import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.colorText,
    required this.isLoading,
  });
  final String text;
  final void Function()? onTap;
  final Color? color;
  final Color? colorText;
  final bool isLoading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          Colors.pinkAccent.withValues(alpha: 0.1),
        ),
        backgroundColor: WidgetStateProperty.all(widget.color),
        side: WidgetStateProperty.all(BorderSide(style: BorderStyle.none)),
      ),
      onPressed: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        height: 40.h,
        child: Center(
          child:
              widget.isLoading
                  ? CupertinoActivityIndicator(color: Colors.grey)
                  : Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.colorText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }
}
