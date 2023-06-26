import 'package:calculator_practice/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  bool hidetext = false;
  double fonts = 30;
  double fontsi = 40;
  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel em = ContextModel();
        var finalval = expression.evaluate(EvaluationType.REAL, em);
        output = finalval.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hidetext = true;
        fonts = 50;
        if (output.length > 12) {
          fonts = 30;
        }
      }
    } else {
      input = input + value;
      hidetext = false;
      fonts = 30;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.pink.shade400, Colors.orange.shade500])),
          child: const Center(
              child: Text(
            'Calculator App',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hidetext ? '' : input,
                  style: TextStyle(
                      fontSize: fontsi,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: fonts,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          )),
          Row(
            children: [
              buttons(text: 'AC', bcolor: operaatorColor, tcolor: orangeColor),
              buttons(text: '<', bcolor: operaatorColor, tcolor: orangeColor),
              buttons(text: '', bcolor: Colors.transparent),
              buttons(text: '/', bcolor: operaatorColor, tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              buttons(text: '7'),
              buttons(text: '8'),
              buttons(text: '9'),
              buttons(text: '*', bcolor: operaatorColor, tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              buttons(text: '4'),
              buttons(text: '5'),
              buttons(text: '6'),
              buttons(text: '-', bcolor: operaatorColor, tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              buttons(text: '1'),
              buttons(text: '2'),
              buttons(text: '3'),
              buttons(text: '+', bcolor: operaatorColor, tcolor: orangeColor),
            ],
          ),
          Row(
            children: [
              buttons(text: '%', bcolor: operaatorColor, tcolor: orangeColor),
              buttons(text: '0'),
              buttons(text: '.', bcolor: operaatorColor, tcolor: orangeColor),
              buttons(text: '=', bcolor: operaatorColor, tcolor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttons({text, bcolor = buttonColor, tcolor = Colors.white}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: bcolor,
            padding: const EdgeInsets.all(16),
          ),
          onPressed: () => onButtonClick(text),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: tcolor),
            ),
          )),
    ));
  }
}
