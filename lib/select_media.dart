
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:select_media/type/SelectMediaResponse.dart';

import 'select_media_platform_interface.dart';

class SelectMedia {
  Future<String?> getPlatformVersion() {
    return SelectMediaPlatform.instance.getPlatformVersion();
  }

  /// 选择文件
  Future<Map?> selectMedia({
    /// 选择的文件类型、默认全部
    SelectMediaType selectMediaType = SelectMediaType.all,
    /// 最多选择的文件数量、默认最多选择6张图片、视频智能单选
    int maxLength = 6,
    /// 选择视频和录制视频的最大时长、默认五分钟
    int maxSecond = 5 * 60 * 1000,

    /// 是否自动处理文件访问权限(相册、拍照之类的)、默认 true 自动处理
    bool autoPermission = true,
    /// 自动处理文件访问权限及权限弹窗需要传入 context 对象
    BuildContext? context,

  }) {
    debugPrint("文件类型${selectMediaType.index}");
    return SelectMediaPlatform.instance.selectMedia(
      selectMediaType: selectMediaType,
      maxLength: maxLength,
      maxSecond: maxSecond,
      autoPermission: autoPermission,
      context: context
    );
  }

  /// 文件选择完成回调
  void addSubscriber(SelectMediaResponseSubscriber result) {
    return SelectMediaPlatform.instance.addSubscriber(result);
  }
}

/// 选择的文件类型
enum SelectMediaType {
  /// 图片、视频
  all,
  /// 图片、和拍照
  image,
  /// 仅使用照相机拍照
  onlyImage,
  /// 视频、和拍摄视频
  video,
  /// 仅使用照相机拍视频
  onlyVideo
}
