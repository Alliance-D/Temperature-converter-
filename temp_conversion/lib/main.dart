import 'package:flutter/material.dart';
import 'package:temp_conversion/screens/temp_convert.dart';



// The  entry point of the application with `TempConverterApp` as the root widget.
void main() {
  runApp(const TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Converter',
      home: const TempConverterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
