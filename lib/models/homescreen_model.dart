import 'package:flutter/material.dart';
import 'package:todo/screens/calculator_home.dart';
import 'package:todo/screens/hangman_home.dart';
import '../screens/todo_home_screen.dart';

class HomescreenModel with ChangeNotifier {
  Map<int, Map<String, dynamic>> projectList = {
    0: {
      'name': 'Todo',
      'page': const TodoHomeScreen(),
      'image': 'https://www.computerhope.com/jargon/t/task.png'
    },
    1: {
      'name': 'Calculator',
      'page': const CalculatorHomeScreen(),
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/c/cf/Casio_calculator_JS-20WK_in_201901_002.jpg'
    },
    2: {
      'name': 'Hangman Game',
      'page': const HangmanGame(),
      'image':
          'https://media.istockphoto.com/illustrations/simple-illustration-of-hangman-game-illustration-id1196954772?k=20&m=1196954772&s=612x612&w=0&h=nzsr9bCwxp9xW3dp-nBJeXE7TVGqnWtdJpbaXvEyl3E='
    },
  };
  int currentID = 0;

  void changeCurrentIndex(id) {
    currentID = id;
    notifyListeners();
  }
}
