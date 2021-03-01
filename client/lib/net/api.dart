import 'package:im/net/interface.dart';

class Api implements Interface {
  /// 接口实现类,单利化
  // 工厂模式
  factory Api() => _getInstance();
  static Api get instance => _getInstance();
  static Api _instance;

  static Api _getInstance() {
    if (_instance == null) {
      _instance = new Api._internal();
    }
    return _instance;
  }

  // 初始化 方法
  Api._internal() {
    // do something
  }

}
