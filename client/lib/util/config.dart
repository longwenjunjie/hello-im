class Config {
  // 工厂模式
  factory Config() => _getInstance();
  static Config get instance => _getInstance();
  static Config _instance;

  static Config _getInstance() {
    if (_instance == null) {
      _instance = new Config._internal();
    }
    return _instance;
  }

  // 初始化 方法
  Config._internal() {
    // do something
  }

  /// 网络请求配置
  ///
  /// baseUrl
  get baseUrl {
    return "http://www.yunliaoim.com";
  }

  get version {
    return '0.0.1';
  }
}
