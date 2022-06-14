import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo/widget.dart';

class HangmanScreen extends StatefulWidget {
  const HangmanScreen({Key? key}) : super(key: key);

  @override
  State<HangmanScreen> createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  List<String> pressedWords = List.empty(growable: true);
  bool hadPressedHint = false;
  num life = 6;
  List<String> guessThisWord = ['H', 'E', 'L', 'L', 'O'];
  List<String> correctGuess = List.empty(growable: true);
  late List<bool> maskWord =
      List<bool>.filled(guessThisWord.length, true, growable: false);

  void alphabetPressed(String word) {
    bool haveInGuess = guessThisWord.contains(word);
    if (haveInGuess) {
      int duplicateWordNumber =
          guessThisWord.where((e) => e == word).toList().length;
      if (correctGuess.where((e) => e == word).toList().length <
          duplicateWordNumber) {
        var unmaskIndex = guessThisWord.indexOf(word);
        while (!maskWord[unmaskIndex] && unmaskIndex != -1) {
          unmaskIndex = guessThisWord.indexOf(word, unmaskIndex + 1);
        }
        correctGuess.add(word);
        setState(() {
          maskWord[unmaskIndex] = false;
        });
      } else {
        setState(() {
          pressedWords.add(word);
          life -= 1;
        });
      }
    } else {
      setState(() {
        pressedWords.add(word);
        life -= 1;
      });
    }
  }

  Widget headerHangman() {
    return Container(
      height: scaleSize(60),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 36,
              ),
              Container(
                child: Text(
                  life.toString(),
                  style: FontU().hangman(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              )
            ],
          ),
          Text('0',
              style: FontU().hangman(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                hadPressedHint = !hadPressedHint;
              });
            },
            child: Icon(
              Icons.lightbulb,
              color: hadPressedHint ? Colors.white38 : Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget alphabetButton(String text) {
    return Container(
      margin: EdgeInsets.all(3),
      child: ElevatedButton(
        onPressed: () => alphabetPressed(text),
        child: Text(
          text,
          style: FontU().hangman(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            primary: pressedWords.contains(text)
                ? Color.fromARGB(255, 143, 127, 133)
                : const Color(0xfff04181),
            minimumSize: Size(scaleSize(50), scaleSize(55)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

  String displayText() {
    List<String> transfer = List<String>.from(guessThisWord);
    for (int i = 0; i < guessThisWord.length; ++i) {
      transfer[i] = maskWord[i] ? '_' : guessThisWord[i];
    }
    return transfer.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    String _lifeToImage = (life - 6).abs().clamp(0, 6).toString();

    return Scaffold(
      body: Container(
        color: Color(0xff431480),
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              headerHangman(),
              Container(
                margin: EdgeInsets.only(top: scaleSize(25)),
                child: Image(
                  image: AssetImage('lib/assets/$_lifeToImage.png'),
                  height: scaleSize(250),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  displayText(),
                  style: FontU()
                      .hangman(fontSize: scaleSize(50), color: Colors.white),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: scaleSize(25)),
                  child: Table(
                    defaultVerticalAlignment:
                        TableCellVerticalAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      TableRow(children: [
                        TableCell(child: alphabetButton('A')),
                        TableCell(child: alphabetButton('B')),
                        TableCell(child: alphabetButton('C')),
                        TableCell(child: alphabetButton('D')),
                        TableCell(child: alphabetButton('E')),
                        TableCell(child: alphabetButton('F')),
                        TableCell(child: alphabetButton('G')),
                      ]),
                      TableRow(children: [
                        TableCell(child: alphabetButton('H')),
                        TableCell(child: alphabetButton('I')),
                        TableCell(child: alphabetButton('J')),
                        TableCell(child: alphabetButton('K')),
                        TableCell(child: alphabetButton('L')),
                        TableCell(child: alphabetButton('M')),
                        TableCell(child: alphabetButton('N')),
                      ]),
                      TableRow(children: [
                        TableCell(child: alphabetButton('O')),
                        TableCell(child: alphabetButton('P')),
                        TableCell(child: alphabetButton('Q')),
                        TableCell(child: alphabetButton('R')),
                        TableCell(child: alphabetButton('S')),
                        TableCell(child: alphabetButton('T')),
                        TableCell(child: alphabetButton('U')),
                      ]),
                      TableRow(children: [
                        TableCell(child: alphabetButton('V')),
                        TableCell(child: alphabetButton('W')),
                        TableCell(child: alphabetButton('X')),
                        TableCell(child: alphabetButton('Y')),
                        TableCell(child: alphabetButton('Z')),
                        TableCell(child: Container()),
                        TableCell(child: Container()),
                      ]),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
