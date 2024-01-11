import 'dart:developer';

import 'package:http/http.dart';
import 'package:weather_riverpod/constants.dart';
import 'package:weather_riverpod/networking/http_client.dart';

class WeatherRepo {
  final _httpClient = HttpClientClass(client: Client());
  Future<Response> getCurrentWeather(
      {required double latitude, required double longitude}) async {
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$APIKey';
      final response = await _httpClient.get(url);

      if (response.statusCode == 200) {
        return response;
      } else {
        return Future.error(response.statusCode);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
