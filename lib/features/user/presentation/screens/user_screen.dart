import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/core/widgets/gap.dart';
import 'package:instgram/features/user/presentation/widgets/following_and_message_button.dart';
import 'package:instgram/features/user/presentation/widgets/user_name_and_notification_and_more.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  List images = [
    "https://i.pravatar.cc/300?img=1",
    "https://i.pravatar.cc/300?img=1",
    "https://i.pravatar.cc/300?img=1",
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserNameAndNotificationAndMore(userName: 'User name'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Container(
                    width: 90.w,
                    height: 80.h,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pinkAccent, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(150.r),
                    ),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/300?img=1",
                      ),
                    ),
                  ),
                  GapW(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'posts',
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                      ),
                    ],
                  ),
                  GapW(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '18K',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'followers',
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                      ),
                    ],
                  ),
                  GapW(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '300',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'following',
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GapH(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Text(
                    'Category',
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            GapH(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                spacing: 8.w,
                children: [
                  Transform.rotate(angle: -10, child: Icon(Icons.link)),
                  Text(
                    'http/www.google.com',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            GapH(height: 10),
            FollowingAndMessageButton(),
            GapH(height: 20),
            TabBar(
              controller: _controller,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              padding: EdgeInsets.all(3),
              dividerColor: Colors.black,
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              dragStartBehavior: DragStartBehavior.down,
              tabs: [
                Icon(Icons.grid_on),
                Icon(Icons.video_library_outlined),
                Icon(Icons.person_add_alt),
              ],
            ),
            SizedBox(
              height: 360.h,
              child: TabBarView(
                controller: _controller,
                children: [
                  GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.9 / 1.6,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(images[index]);
                    },
                  ),
                  Text('2'),
                  Text('3'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
