import 'package:hive_ce/hive.dart';

class Solve extends HiveObject {
  final String scramble;
  final DateTime date;
  final Duration time;
  String? comment;
  List<String>? tag;
  bool dnf;
  bool mas2;

  Solve({
    required this.scramble,
    required this.date,
    required this.time,
    this.comment,
    this.tag,
    this.dnf=false,
    this.mas2=false,
  });

  
  Map<String, dynamic> toJson(){
    return{
    'scramble' : scramble,
    'date' : date,
    'time' : time,
    'comment' : comment,
    'tag' : tag,
    };
  }
}