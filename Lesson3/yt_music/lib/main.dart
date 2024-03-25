import 'package:flutter/material.dart';
import 'screens/main.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Roboto"),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
      },
    ),
  );
}