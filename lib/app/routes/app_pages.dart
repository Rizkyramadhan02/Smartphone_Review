import 'package:get/get.dart';

import 'package:smartphone_review/app/modules/detail_review/bindings/detail_review_binding.dart';
import 'package:smartphone_review/app/modules/detail_review/views/detail_review_view.dart';
import 'package:smartphone_review/app/modules/home/bindings/home_binding.dart';
import 'package:smartphone_review/app/modules/home/views/home_view.dart';
import 'package:smartphone_review/app/modules/login_page/bindings/login_page_binding.dart';
import 'package:smartphone_review/app/modules/login_page/views/login_page_view.dart';
import 'package:smartphone_review/app/modules/profile_page/bindings/profile_page_binding.dart';
import 'package:smartphone_review/app/modules/profile_page/views/profile_page_view.dart';
import 'package:smartphone_review/app/modules/smartphone_add/bindings/smartphone_add_binding.dart';
import 'package:smartphone_review/app/modules/smartphone_add/views/smartphone_add_view.dart';
import 'package:smartphone_review/splashscreen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.SMARTPHONE_ADD,
      page: () => SmartphoneAddView(),
      binding: SmartphoneAddBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_REVIEW,
      page: () => DetailReviewView(),
      binding: DetailReviewBinding(),
    ),
        GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashScreen(),
    ),
  ];
}
