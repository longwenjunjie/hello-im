import 'package:dartin/dartin.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:im/util/sp.dart';

class Global {
  /// 接口实现类,单利化
  // 工厂模式
  factory Global() => _getInstance();
  static Global get instance => _getInstance();
  static Global _instance;

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }

  // 初始化 方法
  Global._internal() {
    var sp = inject<SpUtil>();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /// 登录
  void onLogin({String mobile, String password, Map content}) {

  }

  /// 注册
  void onRegister({String mobile, String password}) {

  }

  /// 注销
  void onLogout() {

  }

}
