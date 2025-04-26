
import 'package:flutter/material.dart';

Widget welcomeMessage(String name) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Hello, $name',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(' 👋', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    ),
  );
}