import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/hangman_screen.dart';
import 'package:todo/widget.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({Key? key}) : super(key: key);

  @override
  State<HangmanGame> createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff431480),
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              const Header(
                backgroundColor: Color(0xff431480),
                titleColor: Color(0xffffffff),
              ),
              Text(
                'HANGMAN',
                style: FontU()
                    .hangman(color: Colors.white, fontSize: scaleSize(52)),
              ),
              Padding(
                padding: EdgeInsets.only(top: scaleSize(88)),
                child: Image.network(
                  'https://media.istockphoto.com/vectors/hangman-chalk-board-vector-id165812595?k=20&m=165812595&s=612x612&w=0&h=jylRPGEBk-El8ZmOZiWTHY9iHM5umGwZYm_4Q5cmZvc=',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: scaleSize(55)),
                child: Container(
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        child: Ink(
                          width: scaleSize(160),
                          height: scaleSize(60),
                          decoration: BoxDecoration(
                              color: const Color(0xfff04181),
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HangmanScreen()));
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Start',
                                style: FontU().hangman(
                                  color: Colors.white,
                                  fontSize: scaleSize(32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
