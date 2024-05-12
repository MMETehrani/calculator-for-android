import 'dart:ui';
import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:calculator/constants.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dynamic Color',
          theme: ThemeData(
            colorScheme: _getThemeColorScheme(context),
            // colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            useMaterial3: true,
          ),
          // themeMode: ThemeMode.light,
          home: CalculatorApp(),
        );
      },
    );
  }
}

ColorScheme _getThemeColorScheme(BuildContext context) {
  final platform = Theme.of(context).platform;
  if (platform == TargetPlatform.android) {
    final androidVersion = Platform.version;
    final majorVersion =
        int.parse(androidVersion.split('.').first); // استخراج نسخه اصلی
    if (majorVersion < 13) {
      return Theme.of(context).colorScheme.copyWith(
            primary: primary, // رنگ ثابت برای تم اصلی
            secondary: secondary,
            onPrimary: onPrimary,
            onSecondary: onSecondary,
            primaryContainer: primaryContainer,
            onBackground: onBackground,
            background: background,
          );
    } else {
      return Theme.of(context)
          .colorScheme; // Dynamic Colors برای اندروید 13 به بالا
    }
  } else {
    return Theme.of(context).colorScheme; // Dynamic Colors برای iOS
  }
}

class CalculatorApp extends StatefulWidget {
  CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var inputUser = '';
  var reuslt = '';
  double bSize = 75;
  double bBorder = 25;
  void buttomPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(bBorder),
            ),
            backgroundColor: getbackgroundColor(text1),
            // primary:
            minimumSize: Size(bSize, bSize),
            maximumSize: Size(bSize, bSize),
          ),

          // backgroundColor: getbackgroundColor(text1),
          // backgroundColor: getbackgroundColor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                reuslt = '';
              });
            } else {
              buttomPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: gettextColor(text1)),
            ),
          ),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(bBorder),
            ),
            backgroundColor: getbackgroundColor(text2),
            // primary: getbackgroundColor(text1),
            minimumSize: Size(bSize, bSize),
            maximumSize: Size(bSize, bSize),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                inputUser = inputUser.substring(0, inputUser.length - 1);
              });
            } else {
              buttomPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: gettextColor(text2)),
            ),
          ),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(bBorder),
            ),
            backgroundColor: getbackgroundColor(text3),
            // primary: getbackgroundColor(text1),
            minimumSize: Size(bSize, bSize),
            maximumSize: Size(bSize, bSize),
          ),
          onPressed: () {
            buttomPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: gettextColor(text3)),
            ),
          ),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(bBorder),
            ),
            backgroundColor: getbackgroundColor(text4),
            // primary: getbackgroundColor(text4),
            minimumSize: Size(bSize, bSize),
            maximumSize: Size(bSize, bSize),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                reuslt = eval.toString();
              });
            } else {
              buttomPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: gettextColor(text4)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [Icon(Icons.more_vert)],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 100,
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: RichText(
                            // Replace Text widget with RichText
                            text: TextSpan(
                              children: [
                                for (var char in inputUser
                                    .split('')) // Iterate over characters
                                  TextSpan(
                                    text: char,
                                    style: TextStyle(
                                      // Set text color based on operator
                                      color: isOperator(char)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                      fontSize: 64.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            reuslt,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  height: 100,
                  // color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getRow('ac', 'ce', '%', '/'),
                        getRow('7', '8', '9', '*'),
                        getRow('4', '5', '6', '-'),
                        getRow('1', '2', '3', '+'),
                        getRow('00', '0', '.', '='),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color gettextColor(String text) {
    if (isOperator(text)) {
      return Theme.of(context).colorScheme.onSecondary;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  Color getbackgroundColor(String text) {
    if (isOperator(text)) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.secondary;
    }
  }
}
