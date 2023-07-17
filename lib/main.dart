import 'package:flutter/material.dart';
import 'package:restapiproject2/example_four.dart';
import 'package:restapiproject2/example_three.dart';
import 'package:restapiproject2/example_two.dart';
import 'package:restapiproject2/home_screen.dart';
import 'package:restapiproject2/signup.dart';
import 'package:restapiproject2/testOne.dart';
import 'package:restapiproject2/upload_image.dart';

import 'example_fifth.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}
