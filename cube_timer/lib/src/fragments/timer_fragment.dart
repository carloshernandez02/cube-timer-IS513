import 'package:cube_timer/data/classes/solve.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Implementar timer funcional con Scrambles generados de forma aleatoria, quizas agregar estadisticas basicas como media total de los tiempos y Desviacion estandar en este fragmento
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
            child: ElevatedButton(child: Text('meter dato'), onPressed: () {
              Hive.box<Solve>(solveBox).add(Solve(scramble: "U2 F' R2 D L2 U2 R2 F' D' L' B2 R' U' L2 U' F L2 B", date: DateTime.now(), time: Duration(seconds: 12, milliseconds: 96)));
            },),
          )
        ],
      ),
    );
  }
}