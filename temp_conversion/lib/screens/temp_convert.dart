import 'package:flutter/material.dart';

class TempConverterScreen extends StatefulWidget {
  const TempConverterScreen({super.key});

  @override
  State<TempConverterScreen> createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  // Tracks whether conversion is Fahrenheit to Celsius (true) or Celsius to Fahrenheit (false)
  bool isFtoC = true;
  // Controller for the temperature input field
  final TextEditingController tempController = TextEditingController();
  String convertedValue = '';
  // Keeps track of the conversion history strings
  final List<String> history = [];

  // Called when user presses the convert button to calculate the conversion
  void _convert() {
    // Input validation that shows message if input is empty
    final input = tempController.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a temperature');
      return;
    }

    final temp = double.tryParse(input);
    if (temp == null) {
      _showSnackBar('Invalid number entered');
      return;
    }

    double result;
    String entry;

    // Perform conversion depending on selected option
    if (isFtoC) {
      result = (temp - 32) * 5 / 9;
      entry = 'F to C: ${temp.toStringAsFixed(1)}  =>  ${result.toStringAsFixed(2)}';
    } else {
      result = temp * 9 / 5 + 32;
      entry = 'C to F: ${temp.toStringAsFixed(1)} =>  ${result.toStringAsFixed(2)}';
    }

    setState(() {
      convertedValue = result.toStringAsFixed(2);
      history.insert(0, entry);
    });
  }


  /// Shows a brief message at the bottom of the screen, disappearing after 2 seconds
  ///
  /// This is a utility method to display a brief message at the bottom of the
  /// screen. The message is wrapped in a [SnackBar], and the
  /// [ScaffoldMessenger.of] is used to show the message. The duration of the
  /// message is set to 2 seconds, so the message will disappear after that time.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  @override
  void dispose() {
    // Clean up controller when widget is disposed to avoid memory leaks
    tempController.dispose();
    super.dispose();
  }

  // Build for row of radio buttons for conversion selection
  Widget _buildConversionSelection() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                contentPadding: EdgeInsets.zero,
                title: Text('Fahrenheit to Celsius'),
                value: true,
                groupValue: isFtoC,
                onChanged: (value) {
                  setState(() {
                    isFtoC = value!;
                    convertedValue = '';
                    tempController.clear();
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                contentPadding: EdgeInsets.zero,
                title: Text('Celsius to Fahrenheit'),
                value: false,
                groupValue: isFtoC,
                onChanged: (value) {
                  setState(() {
                    isFtoC = value!;
                    convertedValue = '';
                    tempController.clear();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build for row of input field and conversion result
  Widget _buildConversionRow() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: tempController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Enter Temp',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(
              '=',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16),
            Container(
              width: 100,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                convertedValue,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(width: 12),
            IconButton(
              tooltip: 'Clear input & result',
              icon: Icon(Icons.clear),
              onPressed: () {
                tempController.clear();
                setState(() {
                  convertedValue = '';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Build for scrollable history list
  Widget _buildHistoryList() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: history.isEmpty
            ? Center(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No conversions yet', style: TextStyle(fontSize: 16)),
              ))
            : ListView.separated(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: history.length,
                separatorBuilder: (_, __) => Divider(height: 1),
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  title: Text(history[index]),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Converter',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
      ),
      backgroundColor: Color.fromARGB(244, 83, 39, 137),
      centerTitle: true
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Conversion:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            _buildConversionSelection(),
            SizedBox(height: 16),
            _buildConversionRow(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.grey[200],
              ),
              onPressed: _convert,
              child: Text('CONVERT', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            Text(
              'History of conversions made\n(most recent at the top):',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Expanded(child: _buildHistoryList()),
          ],
        ),
      ),
    );
  }
}
