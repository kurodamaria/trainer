import 'package:flutter/material.dart';
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
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.lightBlueAccent
        ),
        scaffoldBackgroundColor: Colors.white
      ),
    );
  }
}
