import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'BMI Calculator',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: BmiCalculator(),
  ));
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  dynamic weight;
  dynamic height;

  List gender = [
    'select Gender',
    'Female',
    'Male',
  ];

  String formattedBmi = '';

  double bmi = 0.0;

  String bmiCategory = '';

  void calculateBmi() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    bmi = (weight / (height * height));
    formattedBmi = bmi.toStringAsPrecision(3);
    bmiCategory = determineBmiCategory(bmi);
  }

  String determineBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Severe thinness';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal';
    } else {
      return 'Obese';
    }
  }

  String avatarPic = '';

  String femaleAvatar =
      'https://img.freepik.com/free-vector/flat-style-woman-avatar_90220-2944.jpg?size=338&ext=jpg&ga=GA1.1.117944100.1729209600&semt=ais_hybrid';
  String maleAvatar =
      'https://img.freepik.com/premium-vector/male-avatar-flat-icon-design-vector-illustration_549488-103.jpg';
  String selectedDefault =
      'https://t3.ftcdn.net/jpg/03/35/13/14/360_F_335131435_DrHIQjlOKlu3GCXtpFkIG1v0cGgM9vJC.jpg';
  String selectedGender = 'select Gender';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 224, 211, 210),
          toolbarHeight: 50,
          title: const Text(
            'BMI Calculator',
            style:
                TextStyle(color: Color.fromARGB(255, 71, 55, 55), fontSize: 30),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 228, 187, 187),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Height: ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 105, 85, 85), fontSize: 24),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        helperText: 'Enter your height in cm please',
                        hintText: 'Enter height',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Weight: ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 105, 85, 85), fontSize: 24),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        helperText: 'Enter your weight in kg please',
                        hintText: 'Enter weight',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    value: selectedGender,
                    items: gender.map((x) {
                      return DropdownMenuItem(
                        value: x,
                        child: Text(x),
                      );
                    }).toList(),
                    onChanged: (var x) {
                      setState(() {
                        selectedGender = x as String;
                        if (selectedGender == 'Female') {
                          avatarPic = femaleAvatar;
                        } else if (selectedGender == 'Male') {
                          avatarPic = maleAvatar;
                        } else {
                          avatarPic = selectedDefault;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatarPic),
                    radius: 70,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          calculateBmi();
                        });
                      },
                      icon: Icon(
                        Icons.calculate,
                        size: 50,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _weightController.clear();
                          _heightController.clear();
                          bmi = 0.0;
                        });
                      },
                      icon: Icon(
                        Icons.refresh,
                        size: 50,
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: 300,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0, 
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'BMI: $formattedBmi',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Category: $bmiCategory',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Entered Weight: ${_weightController.text}',
                            style: TextStyle(fontSize: 20)),
                        Text('Entered Height: ${_heightController.text}',
                            style: TextStyle(fontSize: 20)),
                      ],
                    ))
              ])
            ]),
          ),
        ));
  }
}
