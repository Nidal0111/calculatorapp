import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String output = "0";
  void buttonpressed(String values) {
    setState(() {
      if (values == "C") {
      input = "";
      output = "0";
      return;
    } else if (values == "del") {
      input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      return;
    }
    if (values == "=") {
      try {
        output = _calculate(values).toString();
      } catch (e) {
        output = "Error";
      }
    } else {
      input = input + values;
    }
    });
    
  }
  String evaluateexpression(String expression){
    try{
      return _calculate(expression).toString();
    }
    catch(e){
return "Error";    }
  }

  double _calculate(String expression) {
    expression = expression.replaceAll("x", "*").replaceAll("÷", "/");
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  Widget buildbutton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          buttonpressed(text);
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      color: const Color.fromARGB(31, 18, 18, 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildbutton("C"),
                  buildbutton("%"),
                  buildbutton("del"),
                  buildbutton("/"),
                ],
              ),
              Row(
                children: [
                  buildbutton("7"),
                  buildbutton("8"),
                  buildbutton("9"),
                  buildbutton("x"),
                ],
              ),
              Row(
                children: [
                  buildbutton("4"),
                  buildbutton("5"),
                  buildbutton("6"),
                  buildbutton("-"),
                ],
              ),
              Row(
                children: [
                  buildbutton("1"),
                  buildbutton("2"),
                  buildbutton("3"),
                  buildbutton("+"),
                ],
              ),
              Row(
                children: [
                  buildbutton("00"),
                  buildbutton("0"),
                  buildbutton("."),
                  buildbutton("="),
                ],
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 170, 167, 155),
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.calculate))],
      ),
    );
  }
}
