
import 'package:flutter/material.dart';


class StatItem extends StatelessWidget {
  const StatItem({
    super.key,

    required this.title,
    required this.stat,
  });
  final String title;
  final stat;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 100,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(title),
            const SizedBox(
              height: 8,
            ),
            Text(
              '$stat',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
