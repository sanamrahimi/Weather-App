import 'package:clima_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

//api and key
//https://home.openweathermap.org/api_keys
//git hub for getting json icons code
// https://gist.github.com/tbranyen/62d974681dea8ee0caa1
//https://github.com/erikflowers/weather-icons
