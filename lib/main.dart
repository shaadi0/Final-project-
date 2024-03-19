import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => BMICalculatorScreen()),
        GetPage(name: '/categories', page: () => BMICategoriesScreen()),
      ],
    );
  }
}

class BMICalculatorController extends GetxController {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RxString result = ''.obs;

  void calculateBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    double bmi = weight / (height * height);

    String category;
    if (bmi < 16) {
      category = 'Severe undernourishment';
    } else if (bmi >= 16 && bmi < 17) {
      category = 'Medium undernourishment';
    } else if (bmi >= 17 && bmi < 18.5) {
      category = 'Slight undernourishment';
    } else if (bmi >= 18.5 && bmi < 25) {
      category = 'Normal nutrition state';
    } else if (bmi >= 25 && bmi < 30) {
      category = 'Overweight';
    } else if (bmi >= 30 && bmi < 40) {
      category = 'Obesity';
    } else {
      category = 'Pathological obesity';
    }

    result.value = 'Your BMI is ${bmi.toStringAsFixed(2)} - $category';
  }
}

class BMICalculatorScreen extends StatelessWidget {
  final BMICalculatorController controller = Get.put(BMICalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 213, 245),
        title: Text('BMI Calculator'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/image1.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/image4.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Height (m)'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.calculateBMI();
                },
                child: Text('Calculate BMI'),
              ),
              SizedBox(height: 20),
              Obx(() => Text(
                    controller.result.value,
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/categories');
                },
                child: Text('BMI Category List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BMICategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 202, 232, 247),
        title: Text('BMI Categories'),
      ),
      backgroundColor: Color.fromARGB(255, 232, 215, 242),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/image2.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('BMI Assessment')),
                  DataColumn(label: Text('Category')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('<16 (kg/m^2)')),
                    DataCell(Text('Severe undernourishment')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('16-16.9 (kg/m^2)')),
                    DataCell(Text('Medium undernourishment')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('17-18.4 (kg/m^2)')),
                    DataCell(Text('Slight undernourishment')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('18.5-24.9 (kg/m^2)')),
                    DataCell(Text('Normal nutrition state')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('25-29.9 (kg/m^2)')),
                    DataCell(Text('Overweight')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('30-39.9 (kg/m^2)')),
                    DataCell(Text('Obesity')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('>40 (kg/m^2)')),
                    DataCell(Text('Pathological obesity')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
