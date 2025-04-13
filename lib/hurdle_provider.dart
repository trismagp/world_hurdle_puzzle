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
  int hurdleBoardIndex = 0;
  final lettersPerRow = 5;
  bool wins = false;

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

  inputLetter(String letter) {
    if (rowInputs.length < lettersPerRow) {
      hurdleBoard[hurdleBoardIndex] = Wordle(letter: letter);
      hurdleBoardIndex++;
      rowInputs.add(letter);
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeLast();
      print(rowInputs);
      if (hurdleBoardIndex > 0) {
        hurdleBoard[hurdleBoardIndex - 1] = Wordle(letter: '');
        hurdleBoardIndex--;
      }
    }

    notifyListeners();
  }

  bool get isAValidWord =>
      totalWords.contains(rowInputs.join('').toLowerCase());

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;

  void submitWord() {
    print(rowInputs.join(''));
    print(isAValidWord);
  }

  void checkAnswer() {
    if (rowInputs.join('') == targetWord) {
      wins = true;
    } else {
      _markLetterOnBoard();
      if (hurdleBoardIndex < 30) {
        rowInputs = [];
      } else {
        print('you lost');
      }
      notifyListeners();
    }
  }

  void playAgain() {
    rowInputs = [];
    hurdleBoardIndex = 0;
    hurdleBoard = [];
    excludedLetters = [];
    genearateRandomWord();
    wins = false;
    generateBoard();
    notifyListeners();
  }

  void _markLetterOnBoard() {
    for (var i = hurdleBoardIndex - lettersPerRow; i < hurdleBoardIndex; i++) {
      if (targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].existsInTarget = true;
      } else {
        hurdleBoard[i].doesNotExistInTarget = true;
        excludedLetters.add(hurdleBoard[i].letter);
      }
    }
  }
}
