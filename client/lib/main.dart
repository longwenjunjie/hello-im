import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:im/util/global.dart';
import 'package:im/provider/theme_provide.dart';
import 'package:im/page/main_page.dart';
import 'package:im/route/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  Provider.debugCheckInvalidValueType = null;

  // 设置android状态栏为透明的沉浸
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    return ChangeNotifierProvider.value(
      value: ThemeProvide(),
      child: Consumer<ThemeProvide>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {'main': (context) => MainPage()},
            initialRoute: 'main',
            onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(builder: (context) => null),
            onGenerateTitle: (context) {
              return "Hello IM";
            },
            theme: provider.getTheme(context: context),
            darkTheme: provider.getTheme(context: context, isDarkMode: true),
          );
        },
      ),
    );
  }
}
