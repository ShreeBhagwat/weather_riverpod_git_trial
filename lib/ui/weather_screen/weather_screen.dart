import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_riverpod/repo/weather_repo.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String temperature = '';
  String weather = '';
  final weatherRepo = WeatherRepo();
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    await _determinePosition().then((value) async {
      final response = await weatherRepo.getCurrentWeather(
          latitude: value.latitude, longitude: value.longitude);
      final responseBody = json.decode(response.body);
      log(responseBody.toString());
      log(responseBody["weather"][0]["main"]);

      setState(() {
        weather = responseBody["weather"][0]["main"];
        temperature = responseBody["main"]["temp"].toString();
      });
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: fetchWeather,
                child: const Text('Get Location'),
              ),
              Text('Weather: $weather'),
              Text('Temperature: $temperature'),
            ],
          ),
        ),
      ),
    );
  }
}
