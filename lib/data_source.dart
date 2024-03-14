import 'dart:convert';

import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/models.dart';
import 'package:http/http.dart' as http;

abstract class DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast();
  Future<WeatherChartData> getChartData();
}

class FakeDataSource implements DataSource {
  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final json = await rootBundle.loadString('assets/weekly_forecast.json');
    return WeeklyForecastDto.fromJson(jsonDecode(json));
  }

  @override
  Future<WeatherChartData> getChartData() async {
    final json = await rootBundle.loadString("assets/chart_data.json");
    return WeatherChartData.fromJson(jsonDecode(json));
  }
}

class RealDataSource implements DataSource {
  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final location = await Location.instance.getLocation();
    final apiUrl = Uri.https("api.open-meteo.com", '/v1/forecast', {
      'latitude': '${location.latitude}',
      'longitude': '${location.longitude}',
      'daily': ['weather_code', 'temperature_2m_max', 'temperature_2m_min'],
      'wind_speed_unit': 'ms',
      'timezone': 'Europe/Berlin',
    });

    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      return WeeklyForecastDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weekly forecast');
    }
  }

  @override
  Future<WeatherChartData> getChartData() async {
    final location = await Location.instance.getLocation();
    final apiUrl = Uri.https("api.open-meteo.com", '/v1/forecast', {
      'latitude': '${location.latitude}',
      'longitude': '${location.longitude}',
      'daily': ['temperature_2m_max', 'temperature_2m_min'],
      'wind_speed_unit': 'ms',
      'timezone': 'Europe/Berlin',
    });
    final response = await http.get(apiUrl);
    return WeatherChartData.fromJson(jsonDecode(response.body));
  }
}