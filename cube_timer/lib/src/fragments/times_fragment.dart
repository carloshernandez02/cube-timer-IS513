import 'package:cube_timer/src/pages/Widgets/timer_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/PBController.dart';

class Times extends StatelessWidget {
  Times({super.key});

  final pb = Get.find<PBController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ValueListenableBuilder(
        valueListenable: Hive.box<Solve>(solveBox).listenable(),
        builder: (context, Box<Solve> box, _) {
          final solves = box.values.toList().reversed.toList();
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _HeaderDelegate(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (solves.isNotEmpty) {
                          box.clear();
                          pb.personalBest.value = null;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All times deleted')),
                          );
                        }
                      },
                      child: const Text('Borrar todos los tiempos'),
                    ),
                  ),
                ),
              ),
              solves.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(
                        child: Text('No hay resoluciones'),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final entry = box
                              .toMap()
                              .entries
                              .toList()
                              .reversed
                              .toList()[index];
                          final solve = entry.value;
                          final solveKey = entry.key;
                          final commentController =
                              TextEditingController(text: solve.comment);

                          return TimerItem(
                            solve: solve,
                            commentText: commentController,
                            commentChange: () {
                              solve.comment = commentController.text;
                              box.put(solveKey, solve);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Comentario guardado')),
                              );
                            },
                            onDelete: () {
                              box.delete(solveKey);
                            },
                            solveKey: solveKey, // Pass the key
                            box: box, // Pass the Hive box
                          );
                        },
                        childCount: solves.length,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _HeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
