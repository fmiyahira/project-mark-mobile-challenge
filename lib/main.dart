import 'package:flutter/material.dart';
import 'package:weather_forecast/src/core/register_dependencies.dart';
import 'package:weather_forecast/src/features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RegisterDependencies.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(fontFamily: 'Archivo'),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
