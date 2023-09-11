import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';

class WhiteCellCount extends StatelessWidget {
  const WhiteCellCount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _WhiteCellCount(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}

class _WhiteCellCount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900; // Adjust this value as needed
    double fontSize = isWideScreen ? 25 : 18;

    final TextEditingController userCalculationController1 = TextEditingController();
    final TextEditingController userCalculationController2 = TextEditingController();
    final TextEditingController userCalculationController3 = TextEditingController();
    final TextEditingController userCalculationController4 = TextEditingController();
    final TextEditingController userCalculationController5 = TextEditingController();

    final userCalculationControllerList = [
      userCalculationController1,
      userCalculationController2,
      userCalculationController3,
      userCalculationController4,
      userCalculationController5
    ];

    final wbcLabelTexts = [
      "Differential",
      "Neutrophil",
      "Lymphocyte",
      "Monocyte",
      "Eosinophil",
      "Basophil",
    ];

    final randomPercentages = _generateRandomPercentages();
    final whiteCellCount = (Random().nextDouble() * (20.0 - 3.0) + 3.0).toStringAsFixed(1);
    final absoluteNumbers = _generateAbsoluteNumbers(randomPercentages, double.parse(whiteCellCount));
    final List<bool> isInputCorrectList = List.filled(5, false);

    AlertDialog checkSubmission(BuildContext context) {
      List<Widget> resultWidgets = [];

      for (int i = 0; i < userCalculationControllerList.length; i++) {
        bool isCorrect = userCalculationControllerList[i].text == absoluteNumbers[i];
        if (absoluteNumbers[i] == "0.00" && userCalculationControllerList[i].text != "") {
          if (int.parse(userCalculationControllerList[i].text) == 0) {
            isCorrect = true;
          }
        }
        isInputCorrectList[i] = isCorrect;

        Color textColor = isCorrect ? Colors.green : Colors.red;

        String resultText =
            'Your Number: ${userCalculationControllerList[i].text} (Actual Number: ${absoluteNumbers[i]})';

        resultWidgets.add(
          RichText(
            text: TextSpan(
              text: resultText,
              style: TextStyle(
                color: textColor,
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
          ),
        );
      }

      return AlertDialog(
        title: const Text("Results"),
        content: SizedBox(
          height: 200, // Adjust the height as needed
          width: 600,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: resultWidgets.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: resultWidgets[index],
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple.shade300),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the AlertDialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WhiteCellCount()),
                    );
                  },
                  child: const Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 24, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('WBC Count Calculations'),
        backgroundColor: Colors.deepPurple.shade300,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'White Blood Cell Count: $whiteCellCount x10^9/L',
                  style: TextStyle(
                    fontSize: fontSize + 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: screenWidth / 1.2,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Table(
                        defaultColumnWidth: const FlexColumnWidth(),
                        border: TableBorder.all(),
                        children: List.generate(
                          wbcLabelTexts.length,
                              (index) {
                            final rowColor =
                            index.isEven ? Colors.white : Colors.grey[100];

                            return TableRow(
                              decoration: BoxDecoration(
                                color: rowColor,
                              ),
                              children: <Widget>[
                                TableCell(
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: index == 0
                                          ? Text(wbcLabelTexts[index],
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold))
                                          : Text(wbcLabelTexts[index],
                                          style: TextStyle(fontSize: fontSize)),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: index == 0
                                          ? Text("Percentages",
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold))
                                          : Text(
                                        index == 0
                                            ? "Percentages"
                                            : "${randomPercentages[index - 1]}%",
                                        style: TextStyle(fontSize: fontSize),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: index == 0
                                          ? Text(
                                        "Absolute numbers (2 decimal places)",
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                      )
                                          : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: isInputCorrectList[index - 1] ? Colors.green : Colors.red,
                                              ),
                                              controller: userCalculationControllerList[index - 1],
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0), // Adjust the top padding as needed
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return checkSubmission(context); // Call the checkSubmission function here
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade300,
                          ),
                          child: const Text("Submit", textScaleFactor: 2.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<String> _generateRandomPercentages() {
    final List<String> percentages = [];
    double remainingPercentage = 100.0;

    for (int i = 0; i < 4; i++) {
      final random = remainingPercentage == 0 ? 0 : (Random().nextInt(remainingPercentage.toInt() + 1));
      percentages.add('$random');
      remainingPercentage -= random;
    }

    percentages.add('$remainingPercentage');

    return percentages;
  }

  List<String> _generateAbsoluteNumbers(List<String> percentages, double whiteCellCount){
    final List<String> absoluteNumbers = [];
    for (int i = 0; i < percentages.length; i++){
      absoluteNumbers.add((int.parse(percentages[i])/100 * whiteCellCount).toStringAsFixed(2));
    }
    return absoluteNumbers;
  }

}