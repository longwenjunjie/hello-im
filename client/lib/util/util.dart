import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

enum Ext { png, jpg, gif, webp }

class Util {
  /// -----------------屏幕适配-----------------
  static setHeight(num height) => ScreenUtil().setHeight(height);
  static setWidth(num height) => ScreenUtil().setWidth(height);
  static get screenWidth => ScreenUtil().screenWidth;
  static get screenHeight => ScreenUtil().screenHeight;
  static get statusBarHeight => ScreenUtil().statusBarHeight;
  static get bottomBarHeight => ScreenUtil().bottomBarHeight;

  /// -----------------颜色适配-----------------
  static ThemeData getTheme({BuildContext context, bool isDark}) {
    return ThemeData(
      // fontFamily: 'PingFangSC',
      scaffoldBackgroundColor: Color(0xFFF2F2F2),
      brightness: isDark ? Brightness.dark : Brightness.light, // 应用程序的整体主题亮度
      primaryColor: isDark ? Colors.black : Colors.white, // App主要部分的背景色
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(size: 16),
        iconTheme: IconThemeData(size: 16, color: Util.color666(context)),
        elevation: 1.0, // 去ios导航阴影
        centerTitle: true,
        shadowColor: Color(0xFFF2F2F2),
      ),
      cardTheme: CardTheme(
        // 去iOS卡片阴影
        shadowColor: Colors.transparent,
      ),
    );
  }

  static Color _dynamicColor({BuildContext context, Color light, Color dark}) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? dark : light;
  }

  static colorWhite(BuildContext context) =>
      _dynamicColor(context: context, light: Colors.white, dark: Colors.black);

  // 白色
  static colorLightWhite(BuildContext context) => _dynamicColor(
      context: context, light: Colors.white, dark: Color(0xFF202020));

  // 灰色
  static colorBackgroudGrey(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFF2F2F2), dark: Color(0xFF202020));

  // 灰色下Item
  static colorItemGrey(BuildContext context) => _dynamicColor(
      context: context, light: Colors.white, dark: Color(0xFF303030));

  static List<Color> colorsCard(BuildContext context) {
    return [
      _dynamicColor(
          context: context, light: Color(0xF5E0E9FE), dark: Color(0xF5727272)),
      _dynamicColor(
          context: context, light: Colors.white, dark: Color(0xFF424242))
    ];
  }

  static colorItemBackground(BuildContext context) => _dynamicColor(
      context: context, light: Colors.white, dark: Color(0xFF424242));

  static colorInfoBackground(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFF8F9FC), dark: Color(0xFF323232));

  static colorCardInfoBackground(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFF8F9FC), dark: Color(0xFF2c2c2c));

  static colorTextFieldBackground(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFF5F6FA), dark: Color(0xFF424242));

  static colorBlue(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFF0099FF), dark: Color(0xFF0099FF));

  static colorRed(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFed5b5b), dark: Color(0xFFed5b5b));

  static colorLightGrey(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFf8f9fc), dark: Color(0xFF070603));

  static colorLight(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFF5F6FA), dark: Color(0xFFe6eaf9));

  static color000(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFF000000), dark: Color(0xFFffffff));

  static color333(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFF333333), dark: Color(0xFFd1d1d1));

  static color666(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFF666666), dark: Color(0xFF999999));

  static color888(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFF888888), dark: Color(0xFF777777));

  static get color999 => Color(0xFF999999);

  static colorLine(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xfff2f2f2), dark: Color(0xFF646464));

  static colorLoginIdentityItemBackground(BuildContext context) =>
      _dynamicColor(
          context: context, light: Color(0xFFf6f8ff), dark: Color(0x10f6f8ff));

  static colorLoginErrorText(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFe73333), dark: Color(0xFFe73333));

  static colorBackground(BuildContext context) => _dynamicColor(
      context: context, light: Colors.white, dark: Color(0xFF2c2c2c));

  static colorMissionCallBackground(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFedf9f0), dark: Color(0x20edf9f0));

  static colorMissionGpsBackground(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFedf3ff), dark: Color(0x20edf3ff));

  static colorMissionCompleteBackground(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFfaf4e7), dark: Color(0x20faf4e7));

  static get colorMissionCallText => Color(0xFF00a32a);

  static get colorMissionGpsText => Color(0xFF3264dc);

  static colorAppbarBlue(BuildContext context) {
    return _dynamicColor(
        context: context, light: Color(0xFF2A64EB), dark: Color(0xFF2A64EB));
  }

  static get colorMissionCompleteText => Color(0xFFdf8700);
  static get colorClear => Color(0x00000000);

  static colorEmptyText(BuildContext context) => _dynamicColor(
      context: context, light: Color(0xFFc4d1f0), dark: Color(0xFFc4d1f0));

  /// -----------------字体适配-----------------
  static get font12 => ScreenUtil().setSp(14.0);
  // static get font13 => ScreenUtil().setSp(15.0);
  static get font14 => ScreenUtil().setSp(16.0);
  static get font15 => ScreenUtil().setSp(17.0);
  static get font16 => ScreenUtil().setSp(18.0);
  // static get font17 => ScreenUtil().setSp(19.0);
  // static get font18 => ScreenUtil().setSp(20.0);
  // static get font19 => ScreenUtil().setSp(21.0);
  static get font20 => ScreenUtil().setSp(22.0);
  static get bold => FontWeight.bold;
  static ImageProvider imageNamed(String name, {Ext ext = Ext.png}) {
    String fileExt = ext.toString().split(".").last;
    return AssetImage('assets/images/$name.$fileExt');
  }

  static String fileNamed(String name, {@required String ext}) {
    return "assets/statics/$name.$ext";
  }

  /// -----------------appbar-----------------
  static TextStyle appBarStyle(BuildContext context, {Color color}) {
    return TextStyle(
      fontSize: Util.font16,
      color: color ?? Util.color000(context),
    );
  }

  static void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
