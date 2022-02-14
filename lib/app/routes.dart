import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:trainer/representation/pages/home_page.dart';

class Routes {
  static final homePage = GetPage(
    name: '/',
    page: () => const HomePage(),
    // binding: HomeBinding()
  );

  static const initialRoute = '/';

  static final getPages = <GetPage>[
    homePage,
  ];

  static Future<dynamic>? toWithBlocProvider<T>(
      {required T bloc, required dynamic page, dynamic arguments}) {
    // BlocProvider.value(value: bloc, child: page)
    // return Get.to(page, arguments: arguments);
  }
}
