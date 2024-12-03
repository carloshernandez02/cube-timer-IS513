import 'package:cube_timer/src/controllers/PageIndex.dart';
import 'package:cube_timer/src/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:cube_timer/hive/hive_registar.g.dart';

Future<void> main() async{
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<Solve>(solveBox);
  Get.put(PageIndex());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage()
    );
  }
}