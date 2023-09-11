import 'package:flutter/material.dart';
import 'package:haematology_practice/RBCParameterCalculations.dart';
import 'package:haematology_practice/WhiteCellCount.dart';
import 'CBCSummaryPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width to scale content
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haematology Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Haematology Tester',
        screenWidth: screenWidth, // Pass screen width to MyHomePage
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.screenWidth});
  final String title;
  final double screenWidth; // Added screenWidth property

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Calculate font size and icon size based on screenWidth
    final double fontSize = widget.screenWidth > 900 ? 30 : 20;
    final double iconSize = widget.screenWidth > 900 ? 50 : 30;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Card with a cool background color
            Card(
              color: Colors.blue.shade300,
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TestEnv(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assessment_rounded,
                        size: iconSize,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Anaemia Classifications",
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Card with a cool background color
            Card(
              color: Colors.deepPurple.shade300,
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WhiteCellCount(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calculate,
                        size: iconSize,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "WBC Count Calculations",
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Card with a cool background color
            Card(
              color: Colors.green.shade300,
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RBCParameterCalculations(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        size: iconSize,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "RBC Parameter Calculations",
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}