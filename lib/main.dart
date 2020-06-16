import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/app.dart';

enum OpEnvironments{demo, test, production}
const OpEnvironments opEnvironment = OpEnvironments.demo;

main() {
  runApp(MyApp());
}
