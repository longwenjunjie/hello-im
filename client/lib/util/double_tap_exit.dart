import 'package:flutter/material.dart';
import 'package:im/util/toast.dart';

class DoubleTapExit extends StatefulWidget {
  const DoubleTapExit({
    Key key,
    @required this.child,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Widget child;

  /// 两次点击返回按钮的时间间隔
  final Duration duration;

  @override
  _DoubleTapExitState createState() => _DoubleTapExitState();
}

class _DoubleTapExitState extends State<DoubleTapExit> {
  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _ifExit(context),
      child: widget.child,
    );
  }

  Future<bool> _ifExit(BuildContext context) {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show(msg: '再按一次退出');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
