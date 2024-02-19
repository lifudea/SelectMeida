

import 'package:flutter/cupertino.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';

/// 从客户端返回的文件统一类型
class SelectMediaFile {

  /// 文件类型
  late MediaType _mediaType;

  MediaType get mediaType => _mediaType;

  /// 文件地址
  late String _path;

  String get path => _path;

  /// 文件原始地址 / 客户端中的地址
  late String _rawPath;

  String get rawPath => _rawPath;

  SelectMediaFile(
    this._path,
    /// 文件类型描述
    this._mediaType,
    /// 文件在客户端中的地址
    this._rawPath,
  );


  static Future<SelectMediaFile> createSync(
    /// 文件类型描述
    String mediaTypeMsg,
    /// 文件在客户端中的地址
    String rawPath,
  ) async {
    MediaType _mediaType = MediaType.image;
    String _rawPath = rawPath;
    String _path = "";
    if(mediaTypeMsg == "image/jpeg") {
      _mediaType == MediaType.image;
      _path = await LecleFlutterAbsolutePath.getAbsolutePath(
        uri: rawPath,
        fileExtension: "png"
      ) ?? "";
    } else if(mediaTypeMsg == "video/mp4"){
      _mediaType = MediaType.video;
      _path = await LecleFlutterAbsolutePath.getAbsolutePath(
        uri: rawPath,
        fileExtension: "mp4"
      ) ?? "";
    }
    return SelectMediaFile(_path, _mediaType, _rawPath);
  }
}


/// 单个文件类型
enum MediaType {

  /// 图片
  image,

  /// 视频
  video,

  /// 音频
  audio
}
