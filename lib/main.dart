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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haematology Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Haematology Tester'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              const Text(
                  "Anaemia Classifications",
                  style: TextStyle(fontSize: 30),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TestEnv()));
                  },
                  child: const Icon(
                      Icons.assessment_rounded,
                      size: 50,
                  ),
              )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "WBC Count Calculations",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 15),
                FloatingActionButton(
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WhiteCellCount()));
                  },
                  child: const Icon(
                    Icons.calculate,
                    size: 50,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "RBC Parameter Calculations",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 15),
                FloatingActionButton(
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RBCParameterCalculations()));
                  },
                  child: const Icon(
                    Icons.calculate_outlined,
                    size: 50,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}