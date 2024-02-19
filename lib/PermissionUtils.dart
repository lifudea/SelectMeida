


import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'DialogUtils.dart';
import 'FutureCustom.dart';

/// 权限申请文件
class PermissionUtils {


  // /// 判断是否有无相机权限
  // static Future<bool> getCameraPermission(BuildContext context) async {
  //   Completer<bool> completer = Completer();
  //   Future<bool> future = completer.future;
  //   // 检查相机权限状态
  //   var status = await Permission.camera.status;
  //   if (status.isGranted) {
  //     // 已授权
  //     completer.complete(true);
  //   } else if (status.isDenied) {
  //     // 未授权
  //     completer.complete(true);
  //   } else if (status.isPermanentlyDenied) {
  //     /// 用户拒绝权限、并且不能再次询问
  //     if(context.mounted) {
  //
  //     }
  //   }
  //   return future;
  // }

  /// 请求相机权限
  static Future<bool> getCameraPermission(BuildContext context) async {
    return _permissionCommons(
        context,
        Permission.camera,
        "相机"
    );
  }

  /// 请求相册权限
  static Future<bool> getCameraFilePermission(BuildContext context) async {
    return _permissionCommons(
      context,
      Platform.isIOS ? Permission.photos: Permission.storage,
      "相册"
    );
  }


  static Future<bool> _permissionCommons(
    BuildContext context,
    Permission permission,
    String? msgTitle,
  ) {
    FutureCustom<bool> futureCustom = FutureCustom<bool>();
    permission
      .onDeniedCallback(() {
        /// 申请权限被拒绝
        debugPrint("拒绝1");
        futureCustom.reject("未授权");
      })
      .onGrantedCallback(() {
        /// 权限申请成功
        debugPrint("请求成功");
        futureCustom.resolve(true);
      })
      .onPermanentlyDeniedCallback(() {
        /// 永久拒绝、可通过设置去设置权限
        debugPrint("永久拒绝");
        if(context.mounted) {
          DialogUtils().showDialog(
            context,
            title: "暂无$msgTitle权限、请前往设置打开$msgTitle权限",
            success: () {
              debugPrint("确定回调函数");
              openAppSettings();
              futureCustom.reject("永久拒绝");
            }
          );
        }
      })
      .onRestrictedCallback(() {
        /// 操作系统拒绝该权限、在ios上有效、可能是由于家长功能限制
        debugPrint("操作系统拒绝该权限、在ios上有效、可能是由于家长功能限制");
        futureCustom.reject("操作系统拒绝该权限");
      })
      .onLimitedCallback(() {
        /// ios 14+ 生效、用户授权有限访问
        debugPrint("操作系统拒绝该权限、在ios上有效、可能是由于家长功能现在");
        futureCustom.resolve(true);
      })
      .onProvisionalCallback(() {
        /// ios 12+ 生效、临时授权
        debugPrint("临时授权");
        futureCustom.resolve(true);
      })
      .request();
    return futureCustom.future;
  }
}
