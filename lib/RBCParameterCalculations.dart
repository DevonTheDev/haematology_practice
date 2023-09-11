import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  // Input Masks to make sure correct input is achieved
  final List<TextInputFormatter> inputFormatters = [
    MaskTextInputFormatter(
      mask: '###',
      filter: {'#': RegExp(r'[0-9]')},
    ),
    MaskTextInputFormatter(
      mask: '#.##',
      filter: {'#': RegExp(r'[0-9]')},
    ),
    MaskTextInputFormatter(
      mask: '###',
      filter: {'#': RegExp(r'[0-9]')},
    ),
    MaskTextInputFormatter(
      mask: '0.##',
      filter: {'#': RegExp(r'[0-9]')},
    ),
    MaskTextInputFormatter(
      mask: '##.#',
      filter: {'#': RegExp(r'[0-9]')},
    ),
    MaskTextInputFormatter(
      mask: '###',
      filter: {'#': RegExp(r'[0-9]')},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var fullParameterList = calculateParameters(randomlyGeneratedParameters);

    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900; // Adjust this value as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('RBC Parameter Calculations'),
        backgroundColor: Colors.green.shade300,
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
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'RBC Parameters',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: screenWidth / 1.2, // Set the desired width for the table
            child: Table(
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
                            (fullParameterList[index]),
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
                            inputFormatters: [inputFormatters[index]],
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
          ),
          const SizedBox(height: 20), // Add more spacing if necessary
          ElevatedButton(
            onPressed: () {
              // Handle the button press here
              showResultDialog(context, fullParameterList);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(screenWidth / 1.2, 50),
              textStyle: const TextStyle(fontSize: 24),
              backgroundColor: Colors.green.shade300,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the tutorial when the button is pressed
          showTutorialDialog(context);
        }, // Use a question mark icon
        backgroundColor: Colors.blue,
        child: const Icon(Icons.help), // Set the background color of the button
      ),
    );
  }

  void showResultDialog(BuildContext context, List<String> fullParameterList) {
    // Create a list of indices to skip
    List<int> indicesToSkip = [];
    for (int i = 0; i < randomlyGeneratedParameters.length; i++) {
      if (randomlyGeneratedParameters[i] != 0) {
        indicesToSkip.add(i);
      }
    }

    // Create and show a dialog with the user-entered and correct values
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submitted Values'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              titles.length,
                  (index) {
                if (indicesToSkip.contains(index)) {
                  return Container(); // Skip this row
                } else {
                  return _buildResultRow(
                    titles[index],
                    _getUserValue(index),
                    fullParameterList[index],
                    0.5,
                  );
                }
              },
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade300),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RBCParameterCalculations()));
                },
                child: const Text('Retry', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getUserValue(int index) {
    switch (index) {
      case 0:
        return "${textController0.text} g/L";
      case 1:
        return "${textController1.text} x10^12/L";
      case 2:
        return "${textController2.text} fL";
      case 3:
        return "${textController3.text} L/L";
      case 4:
        return "${textController4.text} pg";
      case 5:
        return "${textController5.text} g/L";
      default:
        return '';
    }
  }

  void showTutorialDialog(BuildContext context) {
    // Create and show a tutorial dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tutorial', style: TextStyle(fontWeight: FontWeight.bold),),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Calculate the RBC Parameters from other known ones using formulas.',
                style: TextStyle(fontSize: 20),
              ),
              // Add more tutorial content here as needed
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close', style: TextStyle(fontSize: 20)),
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

    bool isRandomlyGenerated = randomlyGeneratedParameters.contains(label);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$label:',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          if (!isRandomlyGenerated && userValue.isNotEmpty) // Display user-entered values that are not randomly generated
            Text(
              'User Value: $userValue',
              style: TextStyle(fontSize: 20, color: textColor),
            ),
          if (!isRandomlyGenerated && correctValue.isNotEmpty) // Display correct values that are not randomly generated
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