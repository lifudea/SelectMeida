package com.example.select_media;

/// 选择的文件类型
public class SelectMediaType {
  /// 所有
  public static final int TYPE_ALL = 0;

  /// 图片
  public static final int TYPE_IMAGE = 1;

  /// 仅使用照相机拍照
  public static final int ONLY_IMAGE = 2;

  /// 视频
  public static final int TYPE_VIDEO = 3;

  /// 仅使用照相机拍视频
  public static final int ONLY_VIDEO = 4;


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
        return ONLY_IMAGE;
      case 3:
        return TYPE_VIDEO;
      case 4:
        return ONLY_VIDEO;
    }
    return 0;
  }
}
