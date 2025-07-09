import 'package:get/get.dart';
import 'package:overlaunch/routes/app_bindings.dart';
import 'package:overlaunch/ui/accounts/account_view.dart';
import 'package:overlaunch/ui/home_page.dart';
import 'package:overlaunch/ui/login_home.dart';
import 'package:solana/solana.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.loginPage,
      page: () => HomePage(),
      binding: AppBindings(),
    ),
    GetPage(
      name: _Paths.accountPage,
      page: () => MyAccount(),
      binding: AppBindings(),
    ),
   
  ];
}
