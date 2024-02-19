import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:select_media/select_media.dart';
import 'package:select_media/type/SelectMediaResponse.dart';

import 'select_media_method_channel.dart';

abstract class SelectMediaPlatform extends PlatformInterface {
  /// Constructs a SelectMediaPlatform.
  SelectMediaPlatform() : super(token: _token);

  static final Object _token = Object();

  static SelectMediaPlatform _instance = MethodChannelSelectMedia();

  /// The default instance of [SelectMediaPlatform] to use.
  ///
  /// Defaults to [MethodChannelSelectMedia].
  static SelectMediaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SelectMediaPlatform] when
  /// they register themselves.
  static set instance(SelectMediaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Map?> selectMedia({
    SelectMediaType selectMediaType = SelectMediaType.all,
    int maxLength = 6,
    int maxSecond = 5 * 60 * 1000,
    bool autoPermission = true,
    BuildContext? context,
  }) {
    throw UnimplementedError('selectMedia() has not been implemented.');
  }

  /// 设置客户端文件选择完成回调
  void methodCallHandler(MethodCall methodCall) {
    throw UnimplementedError('methodCallHandler() has not been implemented.');
  }

  /// 添加文件选择完成回调
  void addSubscriber(SelectMediaResponseSubscriber listener) {
    throw UnimplementedError('addSubscriber() has not been implemented.');
  }

  /// 移除文件选择完成回调
  void removeSubscriber(SelectMediaResponseSubscriber listener) {
    throw UnimplementedError('addSubscriber() has not been implemented.');
  }
}


