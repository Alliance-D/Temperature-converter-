# Temperature Converter Flutter App

## Overview
This Flutter app allows users to convert temperatures between Fahrenheit and Celsius. It supports two-way conversion:

- Fahrenheit to Celsius
- Celsius to Fahrenheit

Users enter a temperature value, select the conversion direction, and press the Convert button. The converted value is displayed with two decimal precision. A history of conversions is maintained and shown on screen with the most recent at the top.

## Features
- Two conversion options selectable via radio buttons.
- Input validation with user-friendly error messages.
- Displays converted temperature with two decimal places.
- Maintains and displays a conversion history during app runtime.
- Responsive UI with a clean, modern design.
- Works smoothly in both portrait and landscape orientations.
- Clear button to reset input and output values.
- Uses Flutter’s Material Design components.

## How to Run
1. Make sure Flutter SDK is installed: [Flutter install guide](https://flutter.dev/docs/get-started/install)
2. Clone this repository or copy the source code.
3. Run `flutter pub get` to install dependencies.
4. Use `flutter run` to launch the app on a connected device or emulator.

## Code Structure
- `main.dart`: Entry point that launches the app and displays the `ConverterScreen`.
- `screens/converter_screen.dart`: Contains the `ConverterScreen` widget with UI and conversion logic.


