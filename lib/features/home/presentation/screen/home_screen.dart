import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/core/network/api_constant.dart';
import 'package:instgram/core/widgets/custom_button.dart';
import 'package:instgram/core/widgets/custom_text_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map? data;
  TextEditingController userNameController = TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  Future<void> getInfo({required String userName}) async {
    final uri =
        'https://social-api4.p.rapidapi.com/v1/info?username_or_id_or_url=$userName';
    // parse uri to url => http understand
    final url = Uri.parse(uri);

    final response = await http.get(
      url,
      headers: {
        'X-Rapidapi-Key': ApiConstant.xRapidapiKey,
        'X-Rapidapi-Host': ApiConstant.xRapidapiHost,
      },
    );
    final json = jsonDecode(response.body) as Map;
    final result = json['data'] as Map;
    setState(() {
      data = result;
    });

    response.statusCode == 200
        // ignore: use_build_context_synchronously
        ? ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text('Success', style: TextStyle(color: Colors.black)),
            ),
          ),
        )
        // ignore: use_build_context_synchronously
        : ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text('error', style: TextStyle(color: Colors.black)),
            ),
          ),
        );
  }

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
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                CustomTextField(
                  hint: 'user name',
                  controller: userNameController,
                ),
                SizedBox(),
                CustomButton(
                  text: 'Send',
                  onTap: () {
                    getInfo(userName: userNameController.text);
                  },
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
