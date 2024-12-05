import 'dart:math';

String generateScramble() {
  final random = Random();
  final moves = ['U', 'D', 'L', 'R', 'F', 'B'];
  final modifiers = ['', "'", '2'];
  String lastMove = '';
  String lastAxis = '';
  String scramble = '';

  bool isSameAxis(String move1, String move2) {
    if ((move1 == 'U' || move1 == 'D') && (move2 == 'U' || move2 == 'D')) return true;
    if ((move1 == 'L' || move1 == 'R') && (move2 == 'L' || move2 == 'R')) return true;
    if ((move1 == 'F' || move1 == 'B') && (move2 == 'F' || move2 == 'B')) return true;
    return false;
  }

  int length = random.nextInt(11) + 15;

  for (int i = 0; i < length; i++) {
    String move;
    do {
      move = moves[random.nextInt(moves.length)];
    } while (move == lastMove || isSameAxis(move, lastMove));

    lastMove = move;
    String modifier = modifiers[random.nextInt(modifiers.length)];
    scramble += '$move$modifier ';
  }

  return scramble.trim();
}

