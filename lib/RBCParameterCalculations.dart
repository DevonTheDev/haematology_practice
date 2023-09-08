import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';

void main() {
  runApp(const RBCParameterCalculations());
}

class RBCParameterCalculations extends StatelessWidget {
  const RBCParameterCalculations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _RBCParameterCalculations(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}

class _RBCParameterCalculations extends StatelessWidget {
  final randomlyGeneratedParameters = randomParameters();

  final List<String> titles = [
    'Haemoglobin',
    'Red Cell Count',
    'MCV',
    'PCV',
    'MCH',
    'MCHC',
  ];

  final TextEditingController textController0 = TextEditingController();
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final TextEditingController textController4 = TextEditingController();
  final TextEditingController textController5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fullParameterList = calculateParameters(randomlyGeneratedParameters);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RBC Parameter Calculations'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 1200, // Set the desired width for the table
              child: Column(
                children: [
                  const Text(
                    'RBC Parameters',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20), // Add spacing between title and table
                  Table(
                    border: TableBorder.all(), // Add borders to the table
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List<TableRow>.generate(
                      titles.length,
                          (index) => TableRow(
                        decoration: BoxDecoration(
                          border: Border.all(), // Add borders to the table cells
                          color: index.isEven ? Colors.white : Colors.grey[200], // Alternating row colors
                        ),
                        children: <Widget>[
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0), // Add padding to cell contents
                                child: Text(
                                  titles[index],
                                  style: const TextStyle(fontSize: 24), // Increase text size
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0), // Add padding to cell contents
                                child: randomlyGeneratedParameters[index] != 0
                                    ? Text(
                                  // Display the corresponding value from fullParameterList
                                  '${(fullParameterList[index])}',
                                  style: TextStyle(fontSize: 24), // Increase text size
                                )
                                    : TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24), // Set text size
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none, // Remove underline
                                    ),
                                  ),
                                  controller: index == 0
                                      ? textController0
                                      : index == 1
                                      ? textController1
                                      : index == 2
                                      ? textController2
                                      : index == 3
                                      ? textController3
                                      : index == 4
                                      ? textController4
                                      : textController5, // Create a controller
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add spacing between table and button
            ElevatedButton(
              onPressed: () {
                // Handle the button press here
                showResultDialog(context, fullParameterList);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(400, 50),
                textStyle: const TextStyle(fontSize: 24),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void showResultDialog(BuildContext context, List<String> fullParameterList) {
    // Create and show a dialog with the user-entered and correct values
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submitted Values'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildResultRow('Haemoglobin', "${textController0.text} g/L", fullParameterList[0], 1.0),
              _buildResultRow('Red Cell Count', "${textController1.text} x10^12/L", fullParameterList[1], 0.5),
              _buildResultRow('MCV', "${textController2.text} fL", fullParameterList[2], 1.0),
              _buildResultRow('PCV', "${textController3.text} L/L", fullParameterList[3], 0.1),
              _buildResultRow('MCH', "${textController4.text} pg", fullParameterList[4], 1.0),
              _buildResultRow('MCHC', "${textController5.text} g/L", fullParameterList[5], 1.0),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RBCParameterCalculations()));
                },
                child: const Text('Retry', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultRow(String label, String userValue, String correctValue, double tolerance) {
    // Extract numbers from userValue and correctValue
    RegExp numberRegExp = RegExp(r'[\d.]+');
    String userNumber = numberRegExp.stringMatch(userValue) ?? '';
    String correctNumber = numberRegExp.stringMatch(correctValue) ?? '';

    // Parse numbers as doubles
    double userDouble = double.tryParse(userNumber) ?? 0.0;
    double correctDouble = double.tryParse(correctNumber) ?? 0.0;

    // Check if the user's value is within the tolerance of the correct value
    bool isMatch = (userDouble >= correctDouble - tolerance) && (userDouble <= correctDouble + tolerance);
    Color textColor = isMatch ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$label:',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 8),
          Text(
            'User Value: $userValue',
            style: TextStyle(fontSize: 20, color: textColor),
          ),
          Text(
            'Correct Value: $correctValue',
            style: TextStyle(fontSize: 20, color: textColor),
          ),
        ],
      ),
    );
  }
}

List<double> randomParameters(){
  List<double> parameters = [0, 0, 0, 0, 0, 0];

  var groups = [["Hb", "RCC", "PCV"], ["MCHC", "PCV", "RCC"]];
  var selectedGroup = groups[Random().nextInt(groups.length)];

  for (var group in selectedGroup){
    switch (group){
      case "Hb":
        parameters[0] = (70.00 + Random().nextDouble() * (200-70));
        break;
      case "RCC":
        parameters[1] = (3.8 + Random().nextDouble() * (6.5-4.8));
        break;
      case "MCHC":
        parameters[5] = (300 + Random().nextDouble() * (360 - 300));
        break;
      case "PCV":
        parameters[3] = (0.35 + Random().nextDouble() * (0.55-0.35));
        break;
    }
  }

  return parameters;
}

List<String> calculateParameters(List<double> parameters) {
  double result0 = 0.0;
  double result1 = 0.0;
  double result2 = 0.0;
  double result3 = 0.0;
  double result4 = 0.0;
  double result5 = 0.0;

  // If Hb, RCC, and PCV are the given parameters
  if (parameters[0] != 0) {
    result0 = parameters[0];
    result1 = parameters[1];
    result3 = parameters[3];
    result2 = (result3 / result1) * 1000;
    result4 = (result0 / result1);
    result5 = (result0 / result3);
  }
  // If PCV, MCHC, and RCC are the given parameters
  else if (parameters[5] != 0) {
    result3 = parameters[3];
    result5 = parameters[5];
    result1 = parameters[1];
    result0 = (result5 * result3);
    result2 = (result3 / result1) * 1000;
    result4 = (result0 / result1);
  }

  var fullParameters = [
    "${result0.toStringAsFixed(0)} g/L", // Set length to 0 decimal places
    "${result1.toStringAsFixed(2)} x10^12/L", // Set length to 2 decimal places
    "${result2.toStringAsFixed(0)} fL", // Set length to 0 decimal places
    "${result3.toStringAsFixed(2)} L/L", // Set length to 2 decimal places
    "${result4.toStringAsFixed(1)} pg", // Set length to 1 decimal place
    "${result5.toStringAsFixed(0)} g/L", // Set length to 0 decimal places
  ];

  return fullParameters;
}