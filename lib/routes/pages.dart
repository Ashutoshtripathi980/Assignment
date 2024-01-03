import 'package:fbsocial/Animation/drawer_animation.dart';
import 'package:fbsocial/ui/list_builder.dart';
import 'package:fbsocial/ui/login.dart';
import 'package:fbsocial/ui/article_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      //  binding: MyControllerBindings()
    ),
    GetPage(
      name: Routes.article,
      page: () => ArticlePage(index: 0),
      //  binding: MyControllerBindings()
    ),
    GetPage(
      name: Routes.listBuilder,
      page: () => ListBuilder(),
      //  binding: MyControllerBindings()
    ),
    GetPage(
      name: Routes.drawerAnimationPage,
      page: () => const DrawerAnimationPage(),
      //  binding: MyControllerBindings()
    ),
  ];
}
