import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:result_checker/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}
