import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/result.dart';

class FibonacciCalculator extends StatefulWidget {
  const FibonacciCalculator({super.key});
  @override
  FibonacciCalculatorState createState() => FibonacciCalculatorState();
}

class FibonacciCalculatorState extends State<FibonacciCalculator> {
  final TextEditingController _numberController = TextEditingController();
  String _fibonacciResult = '';

  Future<void> _calculateFibonacci() async {
    final int inputNumber = int.tryParse(_numberController.text) ?? 0;

    if (inputNumber <= 0) {
      setState(() {
        _fibonacciResult = 'El número debe ser mayor a cero';
      });
      return;
    }

    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/fibonacci/$inputNumber'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _fibonacciResult = data['fibonacci'].toString();
        });
      } else {
        setState(() {
          _fibonacciResult =
              'La API devolvió un status: ${response.statusCode.toString()}';
        });
      }
    } catch (e) {
      setState(() {
        _fibonacciResult = 'Error al consultar la API';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  isDense: false,
                  labelText: 'Digita un número positivo',
                  contentPadding: EdgeInsets.fromLTRB(36, 8, 36, 8)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculateFibonacci,
              child: const Text('Calcular Fibonacci'),
            ),
            const SizedBox(height: 10),
            FibonacciResultWidget(result: _fibonacciResult),
          ],
        ));
  }
}
