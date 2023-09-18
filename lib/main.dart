import 'package:flutter/material.dart';
import 'package:haematology_practice/Haematology/RBCParameterCalculations.dart';
import 'package:haematology_practice/Haematology/WhiteCellCount.dart';
import 'Haematology/CBCSummaryPage.dart';
import 'package:haematology_practice/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Westward Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/Haematology': (context) => const MyHomePage(),
        '/RBCparameters': (context) => const RBCParameterCalculations(),
        '/WBCparameters': (context) => const WhiteCellCount(),
        '/Anaemiaclassification': (context) => const AnaemiaClassification(),
        '/': (context) => const PortfolioPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 900 ? 30 : 20;
    final double iconSize = screenWidth > 900 ? 50 : 30;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Haematology Practice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCard(
              context,
              Icons.assessment_rounded,
              'Anaemia Classifications',
              '/Anaemiaclassification',
              iconSize,
              fontSize,
              Colors.blue.shade300,
            ),
            buildCard(
              context,
              Icons.calculate,
              'WBC Count Calculations',
              '/WBCparameters',
              iconSize,
              fontSize,
              Colors.deepPurple.shade300,
            ),
            buildCard(
              context,
              Icons.calculate_outlined,
              'RBC Parameter Calculations',
              '/RBCparameters',
              iconSize,
              fontSize,
              Colors.green.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
      BuildContext context,
      IconData iconData,
      String text,
      String routeName,
      double iconSize,
      double fontSize,
      Color cardColor,
      ) {
    return Card(
      color: cardColor,
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                iconData,
                size: iconSize,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}