import 'package:flutter/material.dart';

class FibonacciResultWidget extends StatelessWidget {
  final String result;

  const FibonacciResultWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Text(
      'El resultado es: $result',
      style: const TextStyle(fontSize: 16),
    );
  }
}
