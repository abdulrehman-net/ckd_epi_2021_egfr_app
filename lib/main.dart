import 'dart:math';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'eGFR Calculation App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num _counter = 0;
  int _age = 0;
  String _gender = 'm';
  num _creatinine = 0;

  int D = 142;
  num C = 0.9938;

  num G = 1.012;

  final _formKey = GlobalKey<FormState>();
  final ageController = TextEditingController();
  final creatinineController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _age = int.parse(ageController.text);
      _creatinine = double.parse(creatinineController.text);

      num F = pow(0.9938, _age);

      switch (_gender) {
        case "m":
          {
            // statements;
            if (_creatinine <= 0.9) {
              num A = 0.9;
              num B = -0.302;
              num E = pow((_creatinine / A), B);
              _counter = num.parse((D * E * F).toStringAsFixed(2));
            } else {
              num A = 0.9;
              num B = -1.2;
              num E = pow((_creatinine / A), B);
              _counter = num.parse((D * E * F).toStringAsFixed(2));
            }
          }
          break;
        case "f":
          {
            //statements;
            if (_creatinine <= 0.7) {
              num A = 0.7;
              num B = -0.241;
              num E = pow((_creatinine / A), B);
              _counter = num.parse((D * E * F * G).toStringAsFixed(2));
            } else {
              num A = 0.7;
              num B = -1.2;
              num E = pow((_creatinine / A), B);
              _counter = num.parse((D * E * F * G).toStringAsFixed(2));
            }
          }
          break;
        default:
          {
            if (_creatinine <= 0.9) {
              num A = 0.9;
              num B = -0.302;
              num E = pow((_creatinine / A), B);
              _counter = num.parse((D * E * F).toStringAsFixed(2));
            } else {
              num A = 0.9;
              num B = -1.2;
              num E = pow((_creatinine / A), B);
              _counter = num.parse((D * E * F).toStringAsFixed(2));
            }
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Padding(padding: 
                EdgeInsets.fromLTRB(40, 40, 40, 0),
                
                child:                
                SizedBox(
                    //width: 330,
                    
                    child: Text(
                  "Calculate eGFR",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ))
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            //initialValue: user.patientName ?? "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              } else if (!isNumeric(value)) {
                                return 'Only Numbers Please';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(labelText: 'Age'),
                            controller: ageController,
                          ))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: SizedBox(
                          height: 120,
                          width: 150,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            RadioListTile(
                              title: const Text("Male"),
                              value: "m",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Female"),
                              value: "f",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value.toString();
                                });
                              },
                            ),
                            // RadioListTile(
                            //   title: const Text("Other"),
                            //   value: "o",
                            //   groupValue: _gender,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _gender = value.toString();
                            //     });
                            //   },
                            // )
                          ])))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            //initialValue: user.patientName ?? "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Creatinine value';
                              }
                              // else if (!isNumeric(value)) {
                              //   return 'Only Numbers Please';
                              // }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Creatinine (mg/dL)'),
                            controller: creatinineController,
                          ))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Calculated eGFR is:',
                        ),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // updateUserValue(
                              //     "${firstNameController.text} ${secondNameController.text}");
                              // Navigator.pop(context);
                              _incrementCounter();
                            }
                          },
                          child: const Text(
                            'Calculate',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}


