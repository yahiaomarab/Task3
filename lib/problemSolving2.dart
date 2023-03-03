import 'dart:io';

void main() {
  String input = stdin.readLineSync()!;
  final x = input.split(' ')[0];
  final y = input.split(' ')[1];
  swapNum(x, y);
}
void swapNum( x,  y) {
  print("$y $x");
}


