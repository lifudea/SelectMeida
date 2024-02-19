package com.example.select_media;

import android.app.Activity;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * 选择文件公共对象
 * */
public class SelectMediaPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  static public MethodChannel channel;
  private Activity activity;

  /// 文件选择完成回调名称
  static public String callbackName = "_selectMediaCallbackName";


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "select_media");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + Build.VERSION.RELEASE);
        break;
      case "selectMedia":
        int mediaType = call.argument("mediaType");
        int maxLength = call.argument("maxLength");
        int maxSecond = call.argument("maxSecond");
        Log.e("", "文件最大选择数量" + maxLength);
        Log.e("", "视频最大时长" + maxSecond);
        Log.e("", "传入下标" + mediaType);
        new SelectMedia(
          activity,
          SelectMediaType.getMediaType(mediaType),
          maxLength,
          maxSecond
        );
        /// 调用成功回调到 flutter 端
        result.success(CallbackMap.success());
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    Log.e("试图---> ", "斤斤计较");
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

}
