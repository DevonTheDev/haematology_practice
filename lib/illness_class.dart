import 'dart:core';
import 'dart:math';

class Illness {
  final String name;
  final List<double> cellCountValues; // Array of cell count values
  final List<String> symptoms; // Array of symptoms
  final List<String> RBC_Morphology;
  final List<String> furtherTests;

  // Constructor
  Illness(this.name, {
    required this.cellCountValues,
    required this.symptoms,
    required this.RBC_Morphology,
    required this.furtherTests,
  });

  // Getter for Haemoglobin
  double get haemoglobin => cellCountValues[0];

  // Getter for Red Cell Count
  double get redCellCount => cellCountValues[1];

  // Getter for MCV
  double get mcv => cellCountValues[2];

  // Getter for PCV
  double get pcv => cellCountValues[3];

  // Getter for MCH
  double get mch => cellCountValues[4];

  // Getter for MCHC
  double get mchc => cellCountValues[5];

  // Getter for Platelet Count
  double get plateletCount => cellCountValues[6];
}

// Further Tests
String SerumIron(int degree){
  switch (degree) {
    case -1:
      return "Decreased";
    case 0:
      return "Normal";
    case 1:
      return "Increased";
  }
  return "Normal";
}
String TIBCLevels(int degree){
  switch (degree) {
    case -1:
      return "Decreased";
    case 0:
      return "Normal";
    case 1:
      return "Increased";
  }
  return "Normal";
}
String FerritinLevels(int degree){
  switch (degree) {
    case -1:
      return "Decreased";
    case 0:
      return "Normal";
    case 1:
      return "Increased";
  }
  return "Normal";
}
String ReticulocyteCount(int degree){
  switch (degree) {
    case -1:
      return "Low";
    case 0:
      return "Normal";
    case 1:
      return "High";
  }
  return "High";
}
String CoombsTests(int outcome){
  switch (outcome) {
    case 1:
      return "Positive";
    case 0:
      return "Negative";
  }
  return "Negative";
}

String CBCSummary(Illness illness, String sex) {
  var AnaemiaDegree = "";
  var MCVDegree = "";
  var MCHDegree = "";

  if (sex == "M" && (illness.haemoglobin < 130)) {
    if (illness.haemoglobin >= 100) {
      AnaemiaDegree = "Mild";
    } else if (illness.haemoglobin >= 80) {
      AnaemiaDegree = "Moderate";
    } else {
      AnaemiaDegree = "Marked";
    }

    if (illness.mcv < 80) {
      MCVDegree = "Microcytic";
    } else if (illness.mcv >= 80 && illness.mcv <= 98) {
      MCVDegree = "Normocytic";
    } else {
      MCVDegree = "Macrocytic";
    }

    if (illness.mch < 27) {
      MCHDegree = "Hypochromic";
    } else {
      MCHDegree = "Normochromic";
    }

    return "$AnaemiaDegree $MCVDegree $MCHDegree Anaemia";
  } else if (sex == "F" && (illness.haemoglobin < 115)) {
    if (illness.haemoglobin >= 90) {
      AnaemiaDegree = "Mild";
    } else if (illness.haemoglobin >= 70) {
      AnaemiaDegree = "Moderate";
    } else {
      AnaemiaDegree = "Marked";
    }

    if (illness.mcv < 80) {
      MCVDegree = "Microcytic";
    } else if (illness.mcv >= 80 && illness.mcv <= 98) {
      MCVDegree = "Normocytic";
    } else {
      MCVDegree = "Macrocytic";
    }

    if (illness.mch < 27) {
      MCHDegree = "Hypochromic";
    } else {
      MCHDegree = "Normochromic";
    }

    return "$AnaemiaDegree $MCVDegree $MCHDegree Anaemia";
  }
  return "Error";
}

double generateRandomFloat(double min, double max) {
  final random = Random();
  return min + random.nextDouble() * (max - min);
}