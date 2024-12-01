import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top:80,left: 20,right: 20),
      child: Column(
        children: [
          Card(
            child: Text(style: TextStyle(fontSize: 25),"U2 F' R2 D L2 U2 R2 F' D' L' B2 R' U' L2 U' F L2 B'"), 
            color: Color.fromRGBO(0, 0, 0, 0.063),),
          SizedBox(height: 100,),
          Text(style: TextStyle(fontSize: 100),'0:00'),
          SizedBox(height: 10,),
          Card(
            color: Colors.black,
            child: SizedBox(
              width:250,
              child:Center(child:Text(style: TextStyle(fontSize: 50,color: Colors.white),'Iniciar')),)
          )
        ],
      ),
    );
  }
}