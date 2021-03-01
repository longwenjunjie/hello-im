import 'package:dartin/dartin.dart';

import 'package:im/net/api.dart';
import 'package:im/util/sp.dart';

import 'package:im/provider/main_provider.dart';
import 'package:im/provider/sessions_provider.dart';
import 'package:im/provider/contacts_provider.dart';
import 'package:im/provider/discover_provider.dart';
import 'package:im/provider/profile_provider.dart';

const testScope = DartInScope('test');

/// ViewModel 模块
///
/// 定义ViewModel的构造方式
final viewModelModule = Module([
  factory<MainProvider>(({params}) => MainProvider()),
  factory<SessionsProvider>(({params}) => SessionsProvider()),
  factory<ContactsProvider>(({params}) => ContactsProvider()),
  factory<DiscoverProvider>(({params}) => DiscoverProvider()),
  factory<ProfileProvider>(({params}) => ProfileProvider()),
])
  ..withScope(testScope, [

  ]);

/// api接口
Api api = Api.instance;

/// api 模块
///
/// api 的构造方式
final apiModule = Module([
  single<Api>(({params}) => api),
]);

/// 本地sp存储
SpUtil spUtil;

/// Local 模块
///
/// 定义数据库层及SharedPreference/KV等等本地存储的构造方式
final localModule = Module([
  single<SpUtil>(({params}) => spUtil),
]);

final appModule = [viewModelModule, apiModule, localModule];

/// init
///
/// 初始化 [spUtil] 并启动[DartIn]
init() async {
  spUtil = await SpUtil.getInstance();
  // DartIn start
  startDartIn(appModule);
}
