package com.example.select_media;

/// 选择的文件类型
public class SelectMediaType {
  /// 所有
  public static final int TYPE_ALL = 0;

  /// 图片
  public static final int TYPE_IMAGE = 1;

  /// 视频
  public static final int TYPE_VIDEO = 2;

  /// 音频
  public static final int TYPE_AUDIO = 3;

  /// 仅使用照相机拍照
  public static final int ONLY_IMAGE = 4;

  /// 仅使用照相机拍视频
  public static final int ONLY_VIDEO = 5;

  /// 仅录制音频
  public static final int ONLY_AUDIO = 6;

  /**
   * 根据下标获取选择文件的类型
   * @param typeIndex flutter端传递过来的下标、和 SelectMimeType 类型相对应
   * @return
   */
  public static int getMediaType(int typeIndex) {
    switch (typeIndex) {
      case 0:
        return TYPE_ALL;
      case 1:
        return TYPE_IMAGE;
      case 2:
        return TYPE_VIDEO;
      case 3:
        return TYPE_AUDIO;
      case 4:
        return ONLY_IMAGE;
      case 5:
        return ONLY_VIDEO;
      case 6:
        return ONLY_AUDIO;
    }
    return 0;
  }
}
