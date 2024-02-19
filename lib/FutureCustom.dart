


import 'dart:async';

class FutureCustom<T> {


  FutureCustom() {
    completer = Completer();
    future = completer.future;
  }

  late Completer<T> completer;
  late Future<T> future;

  /// 成功回调
  resolve(T params) {
    completer.complete(params);
  }

  /// 失败回调
  reject(dynamic err) {
    completer.completeError(err);
  }
}
