import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:im/net/api.dart';
import 'package:im/util/sp.dart';

/// BaseProvide
class BaseProvider with ChangeNotifier {
  // api
  final Api api = inject<Api>();
  // sp
  final sp = inject<SpUtil>();

  int pageNo;
  int pageSize;
}

/// page的基类 [PageProvideNode]
///
/// 隐藏了 [Provider] 的调用
abstract class PageProvideNode<T extends ChangeNotifier>
    extends StatelessWidget {
  final T mProvider;

  /// 构造函数
  ///
  /// [params] 代表注入ViewModel[mProvider]时所需的参数，需按照[mProvider]的构造方法顺序赋值
  PageProvideNode({List<dynamic> params})
      : mProvider = inject<T>(params: params);

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // 配置ChangeNotifierProvider
    return ChangeNotifierProvider<T>.value(
      value: mProvider,
      child: buildContent(context),
    );
  }
}
