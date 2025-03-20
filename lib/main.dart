import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/features/home/presentation/screen/home_screen.dart';
import 'package:instgram/features/user/presentation/screens/user_screen.dart';

void main() {
  runApp(Instagram());
}

class Instagram extends StatelessWidget {
  const Instagram({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: UserScreen(),
          ),
    );
  }
}
