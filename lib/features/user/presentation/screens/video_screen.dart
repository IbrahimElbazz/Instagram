import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/core/widgets/gap.dart';
import 'package:instgram/features/user/presentation/widgets/counter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
    required this.videoUrl,
    required this.videoData,
    required this.image,
    required this.userName,
  });
  final String videoUrl;
  final Map videoData;
  final String image;
  final String userName;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  bool isPlay = true;
  bool isCaptionVisible = false;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      )
      ..initialize().then((value) {
        setState(() {
          _videoPlayerController.play();
        });
      });
    super.initState();
  }

  toggleVideo() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      setState(() {
        isPlay = false;
      });
    } else {
      _videoPlayerController.play();
      setState(() {
        isPlay = true;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: GestureDetector(
          onTap: () {
            toggleVideo();
          },
          child: Stack(
            children: [
              VideoPlayer(_videoPlayerController),
              Positioned(
                top: 35.h,

                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    GapW(width: 95),
                    Text(
                      'Your Reels',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GapW(width: 100),
                    Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ],
                ),
              ),
              Positioned(
                top: isCaptionVisible ? 400.h : 450.h,
                right: 20.w,
                child: Column(
                  spacing: 2.h,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                    Text(
                      formatCount(widget.videoData['like_count']),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: isCaptionVisible ? 460.h : 515.h,
                right: 26.w,
                child: Column(
                  spacing: 2.h,
                  children: [
                    Icon(Icons.chat_outlined, color: Colors.white, size: 28.sp),
                    Text(
                      formatCount(widget.videoData['comment_count']),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: isCaptionVisible ? 580.h : 640.h,
                right: 26.w,
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
              Positioned(
                top: isCaptionVisible ? 520.h : 575.h,
                right: 26.w,
                child: Column(
                  spacing: 6.h,
                  children: [
                    Transform.rotate(
                      angle: 5.5,
                      child: Icon(
                        Ionicons.send,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                    ),
                    Text(
                      formatCount(widget.videoData['reshare_count']),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              !isPlay
                  ? Positioned(
                    top: 270.h,
                    left: 130.w,
                    child: Icon(Ionicons.play, size: 100.sp),
                  )
                  : SizedBox.shrink(),
              Positioned(
                top: !isCaptionVisible ? 590.h : 560.h,
                left: 5.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6.h,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 55.w,
                          height: 48.h,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pinkAccent, Colors.orangeAccent],
                            ),
                            borderRadius: BorderRadius.circular(150.r),
                          ),
                          child: CircleAvatar(
                            radius: 30.r,
                            backgroundImage: NetworkImage(widget.image),
                          ),
                        ),
                        GapW(width: 10),
                        Text(
                          widget.userName,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GapW(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCaptionVisible = !isCaptionVisible;
                            });
                          },
                          child: Container(
                            width: 300.w,
                            child: Text(
                              isCaptionVisible
                                  ? widget.videoData['caption']['text']
                                  : '${widget.videoData['caption']['text'].substring(0, 50)}...',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: isCaptionVisible ? null : 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
