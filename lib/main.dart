import 'package:flutter/material.dart';
import 'package:flutter_timer_app/app.dart';
import 'package:flutter_timer_app/feature/timer/di/service_locator.dart';


void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    TimerApp()
  );
}









