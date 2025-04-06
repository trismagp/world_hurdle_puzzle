import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:world_hurdle_puzzle/wordle.dart';
import 'package:english_words/english_words.dart' as words;

class HurdleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';

  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    genearateRandomWord();
  }

  generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  genearateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);
  }
}
