import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:queue_project/core/middleware/mymiddleware.dart';
import 'package:queue_project/view/onboarding.dart';
import 'package:queue_project/view/screen/auth/login.dart';
import 'package:queue_project/view/screen/auth/register.dart';
import 'package:queue_project/view/screen/auth/verify.dart';
import 'package:queue_project/view/screen/home/homepage.dart';
import 'package:queue_project/view/screen/home/inqueue.dart';

class AppRoute {
  static const String login = '/login';
  static const String register = '/register';

  static const String onBoarding = '/onboarding';
  static const String forgetPassword = '/forgetpassword';
  static const String verifyCode = '/verifycode';
  static const String successSignUp = '/success_signup';
  static const String successResetPassword = '/success_resetpassword';
  static const String verifysignup = '/verifysignup';
  static const String homePage = '/homepage';
  static const String Inqueue = '/inqueue';
}

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => OnBoarding(), middlewares: [MyMiddleWare()]),
  GetPage(
    name: AppRoute.login,
    page: () => Login(),
  ),
  // GetPage(
  //     name: AppRoute.login, page: () => Login(), middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoute.register, page: () => Register()),
  GetPage(name: AppRoute.homePage, page: () => HomePage()),
  GetPage(name: AppRoute.verifysignup, page: () => VerifySignup()),
  GetPage(name: AppRoute.Inqueue, page: () => InQueue())
];
