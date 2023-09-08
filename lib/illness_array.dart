import 'dart:math';
import 'illness_class.dart';

// Cell Count Values = {Hb, RCC, MCV, PCV, MCH, MCHC, Platelet Count}

Illness F_Iron_Deficiency_Anaemia = Illness("F Iron Deficiency Anaemia",
    cellCountValues: [generateRandomFloat(65, 114),
      generateRandomFloat(3.8, 4.8),
      generateRandomFloat(65, 80),
      generateRandomFloat(0.27, 0.35),
      generateRandomFloat(17, 25),
      generateRandomFloat(280, 310),
      generateRandomFloat(150, 450)],
    symptoms: ["Shortness of Breath"],
    RBC_Morphology: ["Microcytic Red Blood Cells", "Hypochromic Red Blood Cells"],
    furtherTests: [SerumIron(-1), TIBCLevels(1), FerritinLevels(-1)]);

Illness M_Iron_Deficiency_Anaemia = Illness("M Iron Deficiency Anaemia",
    cellCountValues: [generateRandomFloat(75, 129),
      generateRandomFloat(4.5, 6.5),
      generateRandomFloat(65, 80),
      generateRandomFloat(0.30, 0.38),
      generateRandomFloat(17, 25),
      generateRandomFloat(280, 310),
      generateRandomFloat(150, 450)],
    symptoms: ["Shortness of Breath"],
    RBC_Morphology: ["Microcytic Red Blood Cells", "Hypochromic Red Blood Cells"],
    furtherTests: [SerumIron(-1), TIBCLevels(1), FerritinLevels(-1)]);

Illness F_Lead_Intoxication = Illness("F Lead Intoxication",
    cellCountValues: [generateRandomFloat(65, 114),
          generateRandomFloat(3.8, 4.8),
          generateRandomFloat(65, 80),
          generateRandomFloat(0.27, 0.35),
          generateRandomFloat(17, 25),
          generateRandomFloat(280, 310),
          generateRandomFloat(150, 450)],
    symptoms: ["Abdominal Pain", "Irritability"],
    RBC_Morphology: ["Basophilic Stippling"],
    furtherTests: ["Lead levels showed evidence of lead poisoning"]);

Illness M_Lead_Intoxication = Illness("M Lead Intoxication",
    cellCountValues: [generateRandomFloat(75, 129),
          generateRandomFloat(4.5, 6.5),
          generateRandomFloat(65, 80),
          generateRandomFloat(0.30, 0.38),
          generateRandomFloat(17, 25),
          generateRandomFloat(280, 310),
          generateRandomFloat(150, 450)],
    symptoms: ["Abdominal Pain", "Irritability"],
    RBC_Morphology: ["Basophilic Stippling"],
    furtherTests: ["Lead Levels showed evidence of lead poisoning"]);

Illness F_AutoImmune_Hemolytic_Anaemia = Illness("F Autoimmune Hemolytic Anaemia",
    cellCountValues: [generateRandomFloat(65, 114),
      generateRandomFloat(2.6, 3.6),
      generateRandomFloat(80, 98),
      generateRandomFloat(0.27, 0.35),
      generateRandomFloat(17, 25),
      generateRandomFloat(280, 310),
      generateRandomFloat(150, 450)],
    symptoms: ["Fatigue", "Shortness of Breath"],
    RBC_Morphology: ["Schistocytes, Helmet Cells, Spherocytes, Bite Cells"],
    furtherTests: [CoombsTests(1)]);

Illness M_AutoImmune_Hemolytic_Anaemia = Illness("M Autoimmune Hemolytic Anaemia",
    cellCountValues: [generateRandomFloat(75, 129),
      generateRandomFloat(3.2, 4.3),
      generateRandomFloat(80, 98),
      generateRandomFloat(0.27, 0.35),
      generateRandomFloat(17, 25),
      generateRandomFloat(280, 310),
      generateRandomFloat(150, 450)],
    symptoms: ["Fatigue", "Shortness of Breath"],
    RBC_Morphology: ["Schistocytes, Helmet Cells, Spherocytes, Bite Cells"],
    furtherTests: [CoombsTests(1)]);



var IllnessCollection = [
  F_Iron_Deficiency_Anaemia,
  M_Iron_Deficiency_Anaemia,
  F_Lead_Intoxication,
  M_Lead_Intoxication,
  F_AutoImmune_Hemolytic_Anaemia,
  M_AutoImmune_Hemolytic_Anaemia,
];

Illness generateRandomIllness(String gender){
  List<Illness> allowedIllness = [];
  for (var illness in IllnessCollection){
    if (illness.name[0] == gender){
      allowedIllness.add(illness);
    }
  }
  return allowedIllness[Random().nextInt(allowedIllness.length)];
}