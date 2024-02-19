import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:select_media/select_media.dart';
import 'package:select_media/type/SelectMediaResponse.dart';

import 'PermissionUtils.dart';
import 'select_media_platform_interface.dart';

/// An implementation of [SelectMediaPlatform] that uses method channels.
class MethodChannelSelectMedia extends SelectMediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('select_media');
  /// 文件选择完成回调函数名称
  final String fileCallbackName = "_selectMediaCallbackName";
  /// 文件选择完成回调订阅列表
  final List<SelectMediaResponseSubscriber> subscriberList = [];

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }


  @override
  Future<Map?> selectMedia({
    SelectMediaType selectMediaType = SelectMediaType.all,
    int maxLength = 6,
    int maxSecond = 5 * 60 * 1000,
    bool autoPermission = true,
    BuildContext? context
  }) async {
    /// 设置客户端回调函数
    methodChannel.setMethodCallHandler((call) => methodCallHandler(call));
    try{
      if(autoPermission && context != null && context.mounted) {
        await PermissionUtils.getCameraFilePermission(context);
      }
      Map? map = await methodChannel.invokeMethod<Map>('selectMedia', {
        "mediaType": selectMediaType.index,
        "maxLength": maxLength,
        "maxSecond": maxSecond
      });
      return map;
    } catch(err) {
      debugPrint("失败提示---> $err");
      return {
        "code": 300
      };
    }
  }

  @override
  Future methodCallHandler(MethodCall methodCall) async {
    switch(methodCall.method) {
      case "_selectMediaCallbackName":
        for (var element in subscriberList) {
          SelectMediaResponse mediaResponse = await SelectMediaResponse.createSync(methodCall.arguments);
          element(mediaResponse);
        }
        break;
      default:
        return Future.value();
    }
    return Future.value();
  }

  @override
  void addSubscriber(SelectMediaResponseSubscriber listener) {
    subscriberList.add(listener);
  }

  @override
  void removeSubscriber(SelectMediaResponseSubscriber listener) {
    subscriberList.remove(listener);
  }

}
