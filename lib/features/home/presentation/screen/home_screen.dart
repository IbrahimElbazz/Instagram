import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/core/widgets/custom_button.dart';
import 'package:instgram/core/widgets/custom_text_field.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 170.h),
          child: SafeArea(
            child: Column(
              spacing: 20.h,
              children: [
                Icon(
                  Ionicons.logo_instagram,
                  size: 80.sp,
                  color: Colors.pinkAccent,
                ),
                Text(
                  'Enter user name : ',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
                CustomTextField(hint: 'user name'),
                CustomButton(
                  text: 'Send',
                  onTap: () {},
                  color: Colors.white,
                  colorText: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
