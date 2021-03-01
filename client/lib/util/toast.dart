import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:im/util/util.dart';



enum ToastPosition { top, center, bottom }

class Toast {
  static void show(
      {BuildContext context,
      IconData icon,
      String msg,
      ToastPosition position}) {
    msg = msg ?? "未知错误";
    ToastGravity gravity = ToastGravity.BOTTOM;
    if (position == ToastPosition.center) {
      gravity = ToastGravity.CENTER;
    }
    if (position == ToastPosition.top) {
      gravity = ToastGravity.TOP;
    }
    if (context != null) {
      icon = icon ?? Icons.error;
      FToast fToast = FToast();
      fToast.init(context);
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xB2000000),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Util.colorWhite(context),
              size: 19,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              msg,
              style: TextStyle(
                  fontSize: Util.font15, color: Util.colorWhite(context)),
            ),
          ],
        ),
      );
      fToast.showToast(
        child: toast,
        gravity: gravity,
        toastDuration: Duration(seconds: 2),
      );
    } else {
      Fluttertoast.showToast(
          msg: msg,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xB2000000),
          fontSize: 14.0);
    }
  }

  static FToast fToast;

  static void showLoading({BuildContext context, String msg}) {
    if (context != null) {
      fToast = FToast();
      fToast.init(context);
      Widget toast = Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0x60000000),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            width: 200.0,
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: SpinKitFadingCube(
                    color: Util.colorWhite(context),
                    size: 25.0,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  child: Text(
                    msg ?? "加载中",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(seconds: 50),
      );
    }
  }

  static void hideLoading() {
    if (fToast != null) {
      fToast.removeCustomToast();
    }
  }

  // 显示Error
  static showError(
      {@required BuildContext context, String title, String content}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title ?? "提示",
            style: TextStyle(
              fontSize: Util.font14,
              height: 1.8,
              color: Util.color000(context),
            ),
          ),
          content: Text(
            content ?? "未知错误",
            style: TextStyle(
              fontSize: Util.font14,
              height: 1.8,
              color: Util.color000(context),
            ),
          ),
          actions: <Widget>[
            Container(
              child: FlatButton(
                child: new Text(
                  "确定",
                  style: TextStyle(
                    color: Util.colorBlue(context),
                    fontSize: Util.font14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static showUpdate(
      {@required BuildContext context, String version, String updateType, String content, String url}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        List<Widget> actions = [];
        if (updateType == '0') {
          actions.add(Container(
            child: FlatButton(
              child: new Text(
                '取消',
                style: TextStyle(
                  color: Util.color666(context),
                  fontSize: Util.font14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),);
        }
        actions.add(Container(
          child: FlatButton(
            child: new Text(
              '确定',
              style: TextStyle(
                color: Util.colorBlue(context),
                fontSize: Util.font14,
              ),
            ),
            onPressed: () {
              Util.launchURL(url);
            },
          ),
        ),);
        return CupertinoAlertDialog(
          title: Text(
            (updateType == '2' ? '关键更新' : '特性更新') + '($version)',
            style: TextStyle(
              fontSize: Util.font14,
              height: 1.8,
              color: Util.color000(context),
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              fontSize: Util.font14,
              height: 1.8,
              color: Util.color000(context),
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  static showAlert(
      {@required BuildContext context,
      String title,
      String content,
      Color color,
      String cancelText,
      String confirmText,
      void Function() onCancel,
      void Function() onConfirm}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(
                    fontSize: Util.font14,
                    height: 1.8,
                    color: Util.color000(context),
                  ),
                )
              : null,
          content: Text(
            content,
            style: TextStyle(
              fontSize: Util.font14,
              height: 1.8,
              color: Util.color000(context),
            ),
          ),
          actions: <Widget>[
            Container(
              child: FlatButton(
                child: new Text(
                  cancelText ?? "取消",
                  style: TextStyle(
                    color: Util.color666(context),
                    fontSize: Util.font14,
                  ),
                ),
                onPressed: onCancel ??
                    () {
                      Navigator.of(context).pop();
                    },
              ),
            ),
            Container(
              child: FlatButton(
                child: new Text(
                  confirmText ?? "确定",
                  style: TextStyle(
                    color: color ?? Util.colorBlue(context),
                    fontSize: Util.font14,
                  ),
                ),
                onPressed: onConfirm,
              ),
            ),
          ],
        );
      },
    );
  }
}
