import 'package:flutter/material.dart';
import 'package:weather_riverpod/ui/weather_screen/weather_screen.dart';

void main() {
  runApp(WeatherAppRiverpod());
}

asdasdclass WeatherAppRiverpod extends StatelessWidget {
  const WeatherAppRiverpod({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}
