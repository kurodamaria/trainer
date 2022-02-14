import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/tools/keys.dart' as keys;

class TrainerApp extends StatefulWidget {
  const TrainerApp({Key? key}) : super(key: key);

  @override
  State<TrainerApp> createState() => _TrainerAppState();
}

class _TrainerAppState extends State<TrainerApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Get.find<ChunkRepository>(),
      child: GetMaterialApp(
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
          listTileTheme:
              const ListTileThemeData(tileColor: Colors.black, dense: true),
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
