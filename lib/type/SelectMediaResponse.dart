


import 'package:flutter/cupertino.dart';
import 'package:select_media/type/SelectMediaFile.dart';

import '../select_media.dart';


/// 回调类型
typedef SelectMediaResponseSubscriber = Function(SelectMediaResponse selectMediaResponse);


/// 客户端返回的
class SelectMediaResponse {

  SelectMediaResponse(this.code, this.resultList);

  late int code;
  late List<SelectMediaFile> resultList;

  static Future<SelectMediaResponse> createSync(dynamic map) async {
    int code = map["code"];
    List<SelectMediaFile> resultList = [];
    if(map['fileList'] != null && map['fileList'] is List) {
      for(var i = 0; i < map['fileList'].length; i++) {
        SelectMediaFile selectMediaFile = await SelectMediaFile.createSync(
          map['fileList'][i]['mediaTypeMsg'],
          map['fileList'][i]['path']
        );
        resultList.add(selectMediaFile);
      }
    }
    return SelectMediaResponse(code, resultList);

    /// 单个回调文件进行处理
    // SelectMediaResponse fileHandle(dynamic result) {
    //   debugPrint("文件进行处理 $result");
    //   SelectMediaResponse mediaResponse = SelectMediaResponse(result["code"], []);
    //   debugPrint("返回的文件列表---> " + result["fileList"]);
    //   return mediaResponse;
    // }
  }
}

