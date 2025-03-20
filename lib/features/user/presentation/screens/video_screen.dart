import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram/core/widgets/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  bool isPlay = true;

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
              !isPlay
                  ? Positioned(
                    top: 250.h,
                    left: 130.w,
                    child: Icon(Ionicons.play, size: 100.sp),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
