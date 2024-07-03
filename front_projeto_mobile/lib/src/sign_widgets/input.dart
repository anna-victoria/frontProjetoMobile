import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.name
    });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name)
      ],
    );
  }
}