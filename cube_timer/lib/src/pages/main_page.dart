
import 'package:cube_timer/src/pages/Widgets/bottom_bar.dart';
import 'package:cube_timer/src/pages/Widgets/page_viewer.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(image: AssetImage('lib/assets/logo-carrera-ingenieria-en-sistemas.png'),width: 50,height: 50,),
        backgroundColor: Colors.pink,
        centerTitle: true,
        ),
      body: PageViewer(),
      
      bottomNavigationBar:BottomBar(),
    );
  }
}

