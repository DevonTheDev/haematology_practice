import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'illness_array.dart';
import 'illness_class.dart';

class TestEnv extends StatelessWidget {
  const TestEnv({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  var testPatient = Patient();

  // Define a controller to get the user input from text fields
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900; // Adjust this value as needed

    double fontSize = isWideScreen ? 25 : 18;

    final labelTexts = [
      "Haemoglobin",
      "Red Cell Count",
      "MCV",
      "PCV",
      "MCH",
      "MHCH",
      "Platelet Count",
    ];

    final valueTexts = [
      '${testPatient.illness.cellCountValues[0].toInt()} g/L',
      '${testPatient.illness.cellCountValues[1].toStringAsFixed(2)} x10^12/L',
      '${testPatient.illness.cellCountValues[2].toStringAsFixed(1)} fL',
      '${testPatient.illness.cellCountValues[3].toStringAsFixed(2)} L/L',
      '${testPatient.illness.cellCountValues[4].toInt()} pg',
      '${testPatient.illness.cellCountValues[5].toInt()} g/L',
      '${testPatient.illness.cellCountValues[6].toInt()} x10^9/L',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anaemia Classifications'),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blueGrey,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    for (final info in [
                      'Patient #${testPatient.getId}',
                      'Age: ${testPatient.getAge}',
                      'Sex: ${testPatient.getSex}',
                      'Clinical Information: ${testPatient.getSymptoms}',
                    ])
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          info,
                          style: TextStyle(fontSize: fontSize, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: screenWidth / 1.2,
                  padding: const EdgeInsets.all(12),
                  child: Table(
                    defaultColumnWidth: const FlexColumnWidth(),
                    border: TableBorder.all(),
                    children: List.generate(
                      labelTexts.length,
                          (index) {
                        final rowColor = index.isEven ? Colors.white : Colors.grey[100];

                        return TableRow(
                          decoration: BoxDecoration(
                            color: rowColor,
                          ),
                          children: <Widget>[
                            TableCell(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    labelTexts[index],
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    valueTexts[index],
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anaemia Classification',
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: textEditingController,
                      onFieldSubmitted: (userInput) {
                        if (userInput != CBCSummary(testPatient.illness, testPatient.getSex) && userInput != "DebugMode")  {
                          showDialog(
                            context: context, // Pass your BuildContext here
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Wrong Answer"),
                                content: const Text("Your classification isn't quite right. Please try again."),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Patient {
  late int id;
  late int age;
  late String sex;
  late Illness illness;

  Patient() {
    final random = Random();
    id = random.nextInt(1000);
    age = random.nextInt(100 - 18 + 1) + 18;
    sex = random.nextBool() ? 'M' : 'F';
    illness = generateRandomIllness(sex);
  }

  int get getId => id;

  int get getAge => age;

  String get getSex => sex;

  String get getSymptoms => illness.symptoms.toString();
}