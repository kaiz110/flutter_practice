import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widget.dart';

bool isNumberic(String s) {
  return double.tryParse(s) != null;
}

class CalculatorHomeScreen extends StatefulWidget {
  const CalculatorHomeScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorHomeScreen> createState() => _CalculatorHomeScreenState();
}

class _CalculatorHomeScreenState extends State<CalculatorHomeScreen> {
  String output = ''; // display number
  String _output = '';
  double num1 = double.negativeInfinity;
  double num2 = 0;
  String operand = '';
  bool onOperation = false;

  double calculate(operand, num1, num2) {
    switch (operand) {
      case '+':
        print('operant ' + operand);
        return num1 + num2;
      case '-':
        return num1 - num2;
      case 'x':
        return num1 * num2;
      case '/':
        return num1 / num2;
      default:
        return 0;
    }
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 9);
  }

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "";
      num1 = double.negativeInfinity;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      if (output != '' && !onOperation) {
        if (num1 == double.negativeInfinity || operand == '') {
          num1 = double.parse(output);
        } else {
          num2 = double.parse(output);
          num1 = calculate(operand, num1, num2);
          num2 = 0;
        }
        operand = buttonText;
        onOperation = true;
      } else if (output != '' && onOperation) {
        operand = buttonText;
      }
    } else if (buttonText == ".") {
      if (output.contains('.') || !RegExp(r'[1-9]').hasMatch(output)) {
        print('no');
      } else {
        _output += '.';
      }
    } else if (buttonText == "=") {
      if (operand != '') {
        num2 = double.parse(output);
        print('num1 ' + num1.toString());
        print('num2 ' + num2.toString());
        num1 = calculate(operand, num1, num2);
        _output = format(num1);
        operand = '';
      } else if (output != '') {
        _output = format(num1);
      }
    } else if ((buttonText == '0' || buttonText == '00') &&
        !RegExp(r'[1-9]').hasMatch(output)) {
      print('duplicate zero without numbers');
    } else {
      if (onOperation) {
        _output = buttonText;
        onOperation = false;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String name) {
    return Expanded(
        child: InkWell(
      onTap: () => buttonPressed(name),
      child: Ink(
        color: Colors.white,
        height: 80,
        child: Center(
            child: Text(
          name,
          style: TextStyle(fontSize: scaleSize(18)),
        )),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Column(
          children: [
            const Header(title: 'Calculator'),
            Expanded(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    output == '' ? '0' : output,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            )),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('/'),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('x'),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('+'),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('0'),
                      buildButton('00'),
                      buildButton('.'),
                      buildButton('-'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: BottomButton(
                      onPress: () => buttonPressed('CLEAR'),
                      centerText: 'Clear',
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 80,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: BottomButton(
                      onPress: () => buttonPressed('='),
                      centerText: '=',
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String centerText;
  const BottomButton(
      {Key? key, required this.onPress, required this.centerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black12, width: 5))),
        height: 80,
        child: InkWell(
          onTap: onPress, // Handle your onTap
          child: Ink(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
                child: Text(centerText,
                    style: TextStyle(fontSize: scaleSize(18)))),
          ),
        ));
  }
}
