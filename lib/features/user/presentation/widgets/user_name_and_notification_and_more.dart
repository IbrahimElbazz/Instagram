import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/core/widgets/gap.dart';
import 'package:ionicons/ionicons.dart';

class UserNameAndNotificationAndMore extends StatelessWidget {
  const UserNameAndNotificationAndMore({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          Text(
            userName,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Ionicons.notifications_outline),
          GapW(width: 10),
          Icon(Icons.more_horiz),
        ],
      ),
    );
  }
}
