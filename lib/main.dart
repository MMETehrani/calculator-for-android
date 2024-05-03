import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  Widget getRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(
            '1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, color: textGrey),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(
            '1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, color: textGrey),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(
            '1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, color: textGrey),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(
            '1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, color: textGrey),
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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  color: backgroundGreyDark,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 100,
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow(),
                      getRow(),
                      getRow(),
                      getRow(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
