import 'package:flutter/material.dart';
import 'package:flutter_calculator/widgets/custom_button.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String enteredNumber = '';
  String result = '';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    ' ',
    '0',
    '.',
    '='
  ];

  bool isOperator(String button) {
    return button == '÷' || button == '×' || button == '-' || button == '+';
  }

  void equalResult() {
    String finalResult = enteredNumber;
    finalResult = finalResult.replaceAll('×', '*');
    finalResult = finalResult.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp;
    try {
      exp = p.parse(finalResult);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
    } catch (e) {
      result = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Calculator',
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 130),
                  child: Text(
                    enteredNumber,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return CustomButton(
                    buttonText: buttons[index],
                    btColor: Theme.of(context).primaryColor,
                    btTextColor: Colors.orange,
                    btSecondaryColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        enteredNumber = '';
                        result = '';
                      });
                    },
                  );
                } else if (index == 1) {
                  return CustomButton(
                    buttonText: buttons[index],
                    btColor: Theme.of(context).primaryColor,
                    btTextColor: Colors.black,
                    btSecondaryColor: Colors.grey.shade300,
                    onPressed: () {
                      setState(() {
                        if (enteredNumber.isNotEmpty) {
                          enteredNumber = enteredNumber.substring(
                              0, enteredNumber.length - 1);
                        }
                      });
                    },
                  );
                } else if (index == 2) {
                  return CustomButton(
                    buttonText: buttons[index],
                    btColor: Theme.of(context).primaryColor,
                    btTextColor: Colors.black,
                    btSecondaryColor: Colors.grey.shade300,
                    onPressed: () {
                      setState(() {
                        if (enteredNumber.isNotEmpty) {
                          double number = double.tryParse(enteredNumber) ?? 0;
                          enteredNumber = (number / 100).toString();
                        }
                      });
                    },
                  );
                } else if (index == 16) {
                  return CustomButton(
                    buttonText: buttons[index],
                    btColor: Theme.of(context).primaryColor,
                    btTextColor: Colors.black,
                    btSecondaryColor: Theme.of(context).primaryColor,
                    onPressed: () {},
                  );
                } else if (index == 19) {
                  return CustomButton(
                    buttonText: buttons[index],
                    btColor: Colors.orange,
                    btTextColor: Colors.white,
                    btSecondaryColor: Colors.orange.shade300,
                    onPressed: () {
                      setState(() {
                        equalResult();
                      });
                    },
                  );
                } else {
                  return CustomButton(
                    buttonText: buttons[index],
                    btColor: Theme.of(context).primaryColor,
                    btTextColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.black,
                    btSecondaryColor: isOperator(buttons[index])
                        ? Colors.orange
                        : Colors.white,
                    onPressed: () {
                      setState(() {
                        enteredNumber += buttons[index];
                      });
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
