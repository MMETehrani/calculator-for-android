import 'package:flutter/material.dart';
// import 'package:math_dart/math_dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ماشین حساب',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _currentNumber = ''; // متغیر برای ذخیره عدد فعلی
  String _displayText = ''; // متغیر برای نمایش اعداد و عملگرها
  List<String> _numbers = []; // لیست برای ذخیره اعداد
  List<String> _operators = []; // لیست برای ذخیره عملگرها
  double _result = 0; // متغیر برای ذخیره نتیجه

  void _handleInput(String input) {
    setState(
      () {
        if (isNumber(input)) {
          _currentNumber += input;
          _displayText += input;
        } else if (input == '=') {
          _calculate();
        } else {
          if (_currentNumber != '') {
            _numbers.add(_currentNumber);
            _currentNumber = '';
          }
          _operators.add(input);
          _displayText += input;

          // تغییر رنگ دکمه عملگر
          if (input == '+' || input == '-' || input == '*' || input == '/') {
            // ... (کد تغییر رنگ دکمه عملگر)
          }
        }
      },
    );
  }

  void _calculate() {
    if (_numbers.length <= 1) {
      return;
    }

    double num1 = double.parse(_numbers[0]);
    double num2;

    for (int i = 1; i < _numbers.length; i++) {
      String operator = _operators[i - 1];
      num2 = double.parse(_numbers[i]);

      switch (operator) {
        case '+':
          num1 += num2;
          break;
        case '-':
          num1 -= num2;
          break;
        case '*':
          num1 *= num2;
          break;
        case '/':
          num1 /= num2;
          break;
      }
    }

    setState(() {
      _displayText = num1.toStringAsFixed(2);
      _result = num1;
      _numbers.clear();
      _operators.clear();
      _currentNumber = '';
    });
  }

  void _clear() {
    setState(() {
      _displayText = '';
      _numbers.clear();
      _operators.clear();
      _result = 0;
      _currentNumber = '';
    });
  }

  bool isNumber(String input) {
    return '1234567890'.contains(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ماشین حساب'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              _displayText,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
              child: GridView.count(crossAxisCount: 4, children: [
            ElevatedButton(
              onPressed: () => _handleInput('2'),
              child: Text('2'),
            ),
            ElevatedButton(
              onPressed: () => _handleInput('+'),
              child: Text('+'),
            ),
            ElevatedButton(
              onPressed: () => _handleInput('='),
              child: Text('='),
            ),
          ]))
        ]));
  }
}
