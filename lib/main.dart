import 'package:flutter/material.dart';
import 'package:imc_calculator/modules/calculator/pages/calculator.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Colors.red.shade700,
          onPrimary: Colors.white,
          brightness: Brightness.dark,
          secondary: Colors.grey.shade800,
          onSecondary: Colors.grey.shade900,
          error: Colors.blueGrey.shade800,
          onError: Colors.blueGrey.shade900,
          background: Colors.grey.shade700,
          onBackground: Colors.white,
          onSurface: Colors.white,
          surface: Colors.grey.shade900,
        ),
      ),
      home: CalculatorPage(),
    );
  }
}
