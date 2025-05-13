import 'package:flutter/material.dart';
abstract class Units {
double convertHeight(double height);
double convertWeight(double weight);
}
class ImperialUnits implements Units {
double convertHeight(double height) {
return height * 0.3048;
}
double convertWeight(double weight) {
return weight * 0.453592;
}
}
class MetricUnits implements Units {
double convertHeight(double height) {
return height / 100;
}
double convertWeight(double weight) {
return weight;
}
}
// BMI Calculation Class
class BMICalculator {
double calculateBMI(double height, double weight, Units units) {
height = units.convertHeight(height);
weight = units.convertWeight(weight);
return weight / (height * height);
}
String categorizeBMI(double bmi) {
if (bmi < 18.5) {
return 'Underweight';
} else if (bmi >= 18.5 && bmi < 24.9) {
return 'Normal weight';
} else if (bmi >= 25 && bmi < 29.9) {
return 'Overweight';
} else {
return 'Obese';
}
}
}
void main() {
runApp(BMICalculatorApp());
}
class BMICalculatorApp extends StatefulWidget {
_BMICalculatorAppState createState() => _BMICalculatorAppState();
}
class _BMICalculatorAppState extends State<BMICalculatorApp> {
final TextEditingController heightController = TextEditingController();
final TextEditingController weightController = TextEditingController();
String selectedUnit = 'imperial';
String bmiResult = '';
String bmiCategory = '';
calculateBMI() {
double height = double.parse(heightController.text);
double weight = double.parse(weightController.text);
Units units;
if (selectedUnit == 'imperial') {
units = ImperialUnits();
} else {
units = MetricUnits();
}
BMICalculator bmiCalculator = BMICalculator();
double bmi = bmiCalculator.calculateBMI(height, weight, units);
String category = bmiCalculator.categorizeBMI(bmi);
setState(() {
bmiResult = bmi.toStringAsFixed(2);
bmiCategory = category;
});
}
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
home: Scaffold(
appBar: AppBar(
title: Text('BMI Calculator App'),
backgroundColor: const Color.fromARGB(255, 193, 151, 219),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: <Widget>[
Text(
'What is your height and weight:',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 50),
TextField(
controller: heightController,
decoration: InputDecoration(
labelText: selectedUnit == 'imperial' ? 'Height (ft)' : 'Height (cm)',
border: OutlineInputBorder(),
),
),
SizedBox(height: 50),
TextField(
controller: weightController,
decoration: InputDecoration(
labelText: selectedUnit == 'imperial' ? 'Weight (lbs)' : 'Weight (kg)',
border: OutlineInputBorder(),
),
),
SizedBox(height: 20),
DropdownButton<String>(
value: selectedUnit,
onChanged: (String? newValue) {
setState(() {
selectedUnit = newValue!;
});
},
items: <String>['imperial', 'metric']
.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value == 'imperial' ? 'Imperial' : 'Metric'),
);
}).toList(),
),
SizedBox(height: 20),
ElevatedButton(
onPressed: calculateBMI,
child: Text('Compute BMI'),
),
SizedBox(height: 40),
if (bmiResult.isNotEmpty)
Column(
children: <Widget>[
Text(
'BMI Result: $bmiResult',
style: TextStyle(
fontSize: 40,
fontWeight: FontWeight.bold,
color: Color.fromARGB(255, 0, 85, 232),
),
),
SizedBox(height: 10),
Text(
'Status: $bmiCategory',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
],
),
],
),
),
),
);
}
}