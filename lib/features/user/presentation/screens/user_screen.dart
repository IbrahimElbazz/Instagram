import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:instgram/core/network/api_constant.dart';
import 'package:instgram/core/widgets/gap.dart';
import 'package:instgram/features/user/presentation/screens/video_screen.dart';
import 'package:instgram/features/user/presentation/widgets/counter.dart';
import 'package:instgram/features/user/presentation/widgets/following_and_message_button.dart';
import 'package:instgram/features/user/presentation/widgets/user_name_and_notification_and_more.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, required this.userData});
  final Map userData;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  List posts = [];
  List reels = [];
  // get posts
  Future<void> getPosts() async {
    final userName = widget.userData['username'];
    final uri =
        'https://social-api4.p.rapidapi.com/v1/posts?username_or_id_or_url=$userName';
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
    final result = json['data']['items'] as List;
    setState(() {
      posts = result;
    });
  }

  // get reels
  Future<void> getReels() async {
    final userName = widget.userData['username'];
    final uri =
        'https://social-api4.p.rapidapi.com/v1/reels?username_or_id_or_url=$userName';
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
    final result = json['data']['items'] as List;
    setState(() {
      reels = result;
    });
  }

  late TabController _controller;

  @override
  void initState() {
    getPosts();
    getReels();
    _controller = TabController(length: 3, vsync: this);
    super.initState();
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
            UserNameAndNotificationAndMore(
              userName: widget.userData['username'] ?? "",
            ),
            Column(
              children: [
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
                            widget.userData['profile_pic_url'] ?? "",
                          ),
                        ),
                      ),
                      GapW(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userData['profile_type'] == '0'
                                ? "0"
                                : formatCount(widget.userData['media_count']),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            'posts',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                      GapW(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatCount(widget.userData['follower_count']),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            'followers',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                      GapW(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatCount(widget.userData['following_count']),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            'following',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            ),
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
                      Expanded(
                        child: Text(
                          widget.userData['full_name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GapH(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.userData['biography'],
                          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                        ),
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
                      Expanded(
                        child: Text(
                          widget.userData['threads_profile_glyph_url'] ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
              height: 300.h,

              child: TabBarView(
                controller: _controller,
                children: [
                  GridView.builder(
                    itemCount: posts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.9 / 1.6,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Image.network(post['thumbnail_url']);
                    },
                  ),
                  GridView.builder(
                    itemCount: reels.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.9 / 1.6,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final reel = reels[index];
                      return GestureDetector(
                        onTap: () {
                          print(reel['video_url']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return VideoScreen(videoUrl: reel['video_url']);
                              },
                            ),
                          );
                        },
                        child: Image.network(reel['thumbnail_url']),
                      );
                    },
                  ),
                  Text(''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
