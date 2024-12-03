import 'package:hive_ce/hive.dart';
import 'package:cube_timer/data/classes/solve.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Solve>()
])

class HiveAdapters {}