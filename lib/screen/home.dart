import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var input = '';
  var output = '';

  void onButtonClick(value) {
    setState(() {
      if (value == 'AC') {
        input = '';
        output = '';
      } else if (value == '⌫') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp =
              p.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: 45),
                  )
                ],
              ),
            )),

            // Buttons
            Row(
              children: [
                button(text: 'AC', textcolor: Colors.deepOrange),
                button(text: '⌫', textcolor: Colors.deepOrange),
                button(text: '%', textcolor: Colors.deepOrange),
                button(text: '÷', textcolor: Colors.deepOrange),
              ],
            ),
            Row(
              children: [
                button(text: '7'),
                button(text: '8'),
                button(text: '9'),
                button(text: '×', textcolor: Colors.deepOrange),
              ],
            ),
            Row(
              children: [
                button(text: '4'),
                button(text: '5'),
                button(text: '6'),
                button(text: '-', textcolor: Colors.deepOrange),
              ],
            ),
            Row(
              children: [
                button(text: '1'),
                button(text: '2'),
                button(text: '3'),
                button(text: '+', textcolor: Colors.deepOrange),
              ],
            ),
            Row(
              children: [
                button(text: '00'),
                button(text: '0'),
                button(text: '.'),
                button(text: '=', bgColor: Colors.deepOrange),
              ],
            ),
          ],
        ));
  }

  Widget button(
      {required String text,
      Color textcolor = Colors.white,
      Color bgColor = Colors.transparent}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () => onButtonClick(text),
          style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textcolor),
          )),
    ));
  }
}
