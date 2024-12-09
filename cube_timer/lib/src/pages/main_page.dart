
import 'package:cube_timer/src/pages/Widgets/bottom_bar.dart';
import 'package:cube_timer/src/pages/Widgets/page_viewer.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('logo de la carrera.png'),backgroundColor: Colors.pink,),
      body: PageViewer(),
      
      bottomNavigationBar:BottomBar(),
    );
  }
}

