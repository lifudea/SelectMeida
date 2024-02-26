import 'dart:ffi';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:select_media/select_media.dart';
import 'package:select_media/type/SelectMediaFile.dart';
import 'package:select_media/type/SelectMediaResponse.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({
    super.key
  });

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Home> {

  final SelectMedia selectMedia = SelectMedia();

  late List<SelectMediaFile> fileList = [];
  /// 视频播放控制器
  final List<VideoPlayerController> videoPlayerControllerList = [];
  final List<ChewieController> chewieControllerList = [];

  @override
  void initState() {
    super.initState();
    selectMedia.addSubscriber(selectFileCallback);
  }

  @override
  void deactivate() {
    clearVideoController();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(
            top: 0 + MediaQuery.of(context).padding.top,
            bottom: 10 + MediaQuery.of(context).padding.bottom
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(
                    onPressed: () async {
                      var version = await selectMedia.getPlatformVersion();
                      debugPrint("当前版本---> $version");
                    },
                    child: const Text("测试")
                ),
                TextButton(
                    onPressed: () {
                      pauseVideo();
                      selectMedia.selectMedia(
                        context: context,
                        selectMediaType: SelectMediaType.onlyImage
                      );
                    },
                    child: const Text("仅拍照")
                ),
                TextButton(
                    onPressed: () {
                      pauseVideo();
                      selectMedia.selectMedia(
                        context: context,
                        selectMediaType: SelectMediaType.onlyVideo
                      );
                    },
                    child: const Text("仅视频")
                ),
                TextButton(
                    onPressed: () async {
                      pauseVideo();
                      Map? map = await selectMedia.selectMedia(
                        context: context,
                        selectMediaType: SelectMediaType.image
                      );
                      debugPrint("回调结果--->  $map");
                    },
                    child: const Text("选择图片")
                ),
                TextButton(
                    onPressed: () {
                      pauseVideo();
                      selectMedia.selectMedia(
                        context: context,
                        selectMediaType: SelectMediaType.video,
                      );
                    },
                    child: const Text("选择视频")
                ),
                TextButton(
                    onPressed: () {
                      pauseVideo();
                      selectMedia.selectMedia(
                        context: context,
                        selectMediaType: SelectMediaType.all
                      );
                    },
                    child: const Text("选择全部")
                ),
                ...fileList.map((e) {
                  if(e.mediaType == MediaType.image) {
                    return Image(
                      image: FileImage(File(e.path)),
                      fit: BoxFit.cover,
                    );
                  } else if(e.mediaType == MediaType.video){
                    debugPrint("当前文件地址222===> ${e.path}");
                    VideoPlayerController videoPlayerController = VideoPlayerController.file(File(
                      e.path
                    ));
                    ChewieController chewieController = ChewieController(
                      videoPlayerController: videoPlayerController!,
                      autoPlay: true,
                      looping: true
                    );
                    videoPlayerControllerList.add(videoPlayerController);
                    chewieControllerList.add(chewieController);
                    return Container(
                      key: ValueKey(chewieController),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Chewie(
                        controller: chewieController!,
                      ),
                    );
                  }
                  return Image.network("https://img2.baidu.com/it/u=1355873025,3484172281&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1707152400&t=a8627f70539a505750211647609ad68d");
                }).toList(),
              ],
            ),
          ),
        )
    );
  }

  /// 选择文件回调触发
  void selectFileCallback(SelectMediaResponse selectMediaResponse) {
    debugPrint("选择文件回调触发了1${selectMediaResponse.code}");
    debugPrint("文件列表 ${selectMediaResponse.resultList}");
    fileList = selectMediaResponse.resultList;
    setState(() {

    });
  }

  /// 暂停播放视频
  void pauseVideo() {
    for (var element in videoPlayerControllerList) {
      element.pause();
    }
    for (var element in chewieControllerList) {
      element.pause();
    }
  }

  /// 销毁视频控制器
  void clearVideoController() {
    for (var element in videoPlayerControllerList) {
      element.dispose();
    }
    for (var element in chewieControllerList) {
      element.dispose();
    }
  }
}
