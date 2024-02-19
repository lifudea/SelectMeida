

import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class DialogUtils {

  /// 显示弹窗
  YYDialog showDialog(
    BuildContext context,
    {
      required String title,
      required Function success,
      Function? failed
    }
  ) {
    return YYDialog().build(context)
      ..width = 220
      ..borderRadius = 4.0
      ..text(
        padding: const EdgeInsets.all(25.0),
        alignment: Alignment.center,
        text: title,
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
      ..divider()
      ..doubleButton(
        padding: const EdgeInsets.only(top: 10.0),
        gravity: Gravity.center,
        withDivider: true,
        text1: "取消",
        color1: Colors.redAccent,
        fontSize1: 14.0,
        fontWeight1: FontWeight.bold,
        onTap1: () {
          if(failed != null) {
            failed();
          }
        },
        text2: "确定",
        color2: Colors.redAccent,
        fontSize2: 14.0,
        fontWeight2: FontWeight.bold,
        onTap2: () {
          success();
        },
      )
      ..show();
  }
}
