import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State createState() => _CalculatorState();
}

class _CalculatorState extends State {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String? _imc;

  String? get imc => _imc;

  String? imcStatus(String? value) {
    if (value == null) return null;

    final valueParsed = double.parse(value);

    if (valueParsed >= 30) {
      return 'Obeso';
    }
    if (valueParsed >= 24.9) {
      return 'Sobrepeso';
    }
    if (valueParsed >= 18.5) {
      return 'Normal';
    }
    if (valueParsed <= 18.5) {
      return 'Magreza';
    }
    return null;
  }

  void refreshCalc() {
    setState(() {
      heightController.clear();
      weightController.clear();
      _imc = null;
    });
  }

  void calculateImc() {
    if (heightController.text.isNotEmpty && weightController.text.isNotEmpty) {
      setState(() {
        _imc = (double.parse(weightController.text) /
                (double.parse(heightController.text) *
                    double.parse(heightController.text)))
            .toStringAsFixed(2);
      });
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_outline,
              size: 150,
              color: Theme.of(context).colorScheme.primary,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}'),
                        allow: true)
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    label: const Text('Altura:'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  controller: heightController,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    )
                  ],
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    label: const Text('Peso:'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  controller: weightController,
                ),
              ),
            ),
            TextButton(onPressed: calculateImc, child: const Text('Calcular')),
            Center(
              child: imc != null ? const Text('Resultado') : Container(),
            ),
            Center(
              child: imc != null
                  ? Text(
                      '$imc',
                      style: TextStyle(
                          fontSize: 60,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  : Container(),
            ),
            Center(
              child: imc != null
                  ? Text(
                      '${imcStatus(imc)}',
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).colorScheme.onBackground),
                    )
                  : Container(),
            ),
          ]),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        color: Theme.of(context).colorScheme.surface,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: const [
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: refreshCalc,
          child: const Icon(
            Icons.refresh,
            size: 20,
            color: Colors.white,
          )),
    );
  }
}
