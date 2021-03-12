import 'package:im/base/base_provider.dart';
import 'package:im/model/user.dart';

class ProfileProvider extends BaseProvider {
  List datas = [
    User('Hello IM', ''),
    {
      "icon": "setting_favorite_icon",
      "name": "我的收藏",
    },
    {
      "icon": "setting_help_icon",
      "name": "帮助中心",
    },
    {
      "icon": "setting_feedback_icon",
      "name": "意见反馈",
    },
    {
      "icon": "setting_setting_icon",
      "name": "设置",
    },
    {
      "icon": "setting_about_icon",
      "name": "关于",
    }
  ];
}
