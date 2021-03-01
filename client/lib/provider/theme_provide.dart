import 'package:im/util/util.dart';
import 'package:flutter/material.dart';

class ThemeProvide extends ChangeNotifier {
  getTheme({BuildContext context, bool isDarkMode = false}) {
    return Util.getTheme(context: context, isDark: isDarkMode);
  }
}
