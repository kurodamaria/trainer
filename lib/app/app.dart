import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';

class TrainerApp extends StatelessWidget {
  const TrainerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trainer',
      getPages: Routes.getPages,
      initialRoute: Routes.initialRoute,
      theme: ThemeData.light().copyWith(
          dividerColor: Colors.black,
          primaryColor: Colors.black,
          backgroundColor: Colors.white,
          appBarTheme: ThemeData.light().appBarTheme.copyWith(
              color: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              centerTitle: true,
              titleTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 18),
              actionsIconTheme: const IconThemeData(
                color: Colors.black,
              ),
              iconTheme: const IconThemeData(color: Colors.black)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.white,
            foregroundColor: Colors.lightBlueAccent,
          ),
          scaffoldBackgroundColor: Colors.grey[300]),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.white10,
        dividerColor: Colors.white60,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
        cardTheme: const CardTheme(
          color: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textButtonTheme: const TextButtonThemeData(style: ButtonStyle()),
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.black,
          dense: true
        ),
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
