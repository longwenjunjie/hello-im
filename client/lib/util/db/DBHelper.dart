import 'package:im/util/db/DBUtil.dart';

///sqflite数据库操作工具类
//TODO 数据库偶有冲突现象 具体原因未知 (lll￢ω￢)
class DBHelper {
  // 工厂模式
  factory DBHelper() => _getInstance();

  static DBHelper get instance => _getInstance();
  static DBHelper _instance;

  DBHelper._internal() {
    // 初始化
    dbUtil = new DBUtil();
  }

  static DBHelper _getInstance() {
    if (_instance == null) {
      _instance = new DBHelper._internal();
    }
    return _instance;
  }

  DBUtil dbUtil;

  Future<void> connect() async {
    return dbUtil.open();
  }

}
