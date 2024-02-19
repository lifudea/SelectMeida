import 'package:flutter/src/services/message_codec.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:select_media/select_media.dart';
import 'package:select_media/select_media_platform_interface.dart';
import 'package:select_media/select_media_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:select_media/type/SelectMediaResponse.dart';

class MockSelectMediaPlatform
    with MockPlatformInterfaceMixin
    implements SelectMediaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void addSubscriber(SelectMediaResponseSubscriber listener) {
    // TODO: implement addSubscriber
  }

  @override
  void methodCallHandler(MethodCall methodCall) {
    // TODO: implement methodCallHandler
  }

  @override
  void removeSubscriber(SelectMediaResponseSubscriber listener) {
    // TODO: implement removeSubscriber
  }

  @override
  Future<Map?> selectMedia({SelectMediaType selectMediaType = SelectMediaType.all, int maxLength = 6, int maxSecond = 5 * 60 * 1000, bool autoPermission = true, BuildContext? context}) {
    // TODO: implement selectMedia
    throw UnimplementedError();
  }
}

void main() {
  final SelectMediaPlatform initialPlatform = SelectMediaPlatform.instance;

  test('$MethodChannelSelectMedia is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSelectMedia>());
  });

  test('getPlatformVersion', () async {
    SelectMedia selectMediaPlugin = SelectMedia();
    MockSelectMediaPlatform fakePlatform = MockSelectMediaPlatform();
    SelectMediaPlatform.instance = fakePlatform;

    expect(await selectMediaPlugin.getPlatformVersion(), '42');
  });
}
