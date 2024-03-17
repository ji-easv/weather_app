import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app/models/daily_forecast_dto.dart';
import 'package:weather_app/models/models.dart';

import 'models/weekly_forecast.dart';

abstract class DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast();
  Future<WeatherChartData> getChartData();
  Future<DailyForecastDto> getDailyForecast(
      DateTime date); // TODO: Implement hourly forecast
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

  @override
  Future<DailyForecastDto> getDailyForecast(DateTime date) async {
    final json = await rootBundle.loadString("assets/hourly_forecast.json");
    return DailyForecastDto.fromJson(jsonDecode(json));
  }
}

class RealDataSource implements DataSource {
  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final location = await Location.instance.getLocation();
    final apiUrl = _getDailyApiCall(location, [
      'weather_code',
      'temperature_2m_max',
      'temperature_2m_min',
      'sunrise',
      'sunset'
    ]);

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
    final apiUrl = _getDailyApiCall(
        location, ['temperature_2m_max', 'temperature_2m_min']);
    final response = await http.get(apiUrl);
    return WeatherChartData.fromJson(jsonDecode(response.body));
  }

  @override
  Future<DailyForecastDto> getDailyForecast(DateTime date) {
    // TODO: implement getHourlyForecast
    throw UnimplementedError();
  }
}

Uri _getDailyApiCall(LocationData locationData, List<String> variables) {
  // https://api.open-meteo.com/v1/forecast?latitude=55.4703&longitude=8.4519&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,daylight_duration&timezone=Europe%2FBerlin
  return Uri.https("api.open-meteo.com", '/v1/forecast', {
    'latitude': '${locationData.latitude}',
    'longitude': '${locationData.longitude}',
    'daily': variables,
    'wind_speed_unit': 'ms',
    'timezone': 'Europe/Berlin',
  });
}

Uri _getHourlyApiCall(LocationData locationData) {
  return Uri.https("api.open-meteo.com", '/v1/forecast', {
    'latitude': '${locationData.latitude}',
    'longitude': '${locationData.longitude}',
    'hourly': [
      'temperature_2m',
      'precipitation_probability',
      'weather_code',
      'wind_speed_10m',
    ],
    'wind_speed_unit': 'km/h',
    'timezone': 'Europe/Berlin',
    'forecast_days': '1'
  });
}

Uri _getCurrentWeatherApiCall(LocationData locationData) {
  return Uri.https("api.open-meteo.com", '/v1/forecast', {
     'latitude': '${locationData.latitude}',
    'longitude': '${locationData.longitude}',
    'current' : [
      'weather_code',
      'temperature_2m',
      'relative_humidity',
      'precipation',
      'wind_speed_10m',
      'wind_gusts_10m',
    ]
  });
}
