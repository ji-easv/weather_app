import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app/models/current_weather_dto.dart';
import 'package:weather_app/models/daily_forecast_dto.dart';
import 'package:weather_app/models/models.dart';

import 'models/weekly_forecast.dart';

abstract class DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast();
  Future<WeatherChartData> getChartData();
  Future<DailyForecastDto> getHourlyForecast(String dateString);
  Future<CurrentWeatherDto> getCurrentWeather();
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
  Future<DailyForecastDto> getHourlyForecast(String dateString) async {
    final json = await rootBundle.loadString("assets/hourly_forecast.json");
    return DailyForecastDto.fromJson(jsonDecode(json));
  }

  @override
  Future<CurrentWeatherDto> getCurrentWeather() async {
    final json = await rootBundle.loadString("assets/current_weather.json");
    return CurrentWeatherDto.fromJson(jsonDecode(json));
  }
}

class RealDataSource implements DataSource {
  LocationData locationData = LocationData.fromMap({
    "latitude": 55.4765,
    "longitude": 8.4594,
    "accuracy": 0.0,
    "altitude": 0.0,
    "speed": 0.0,
    "speed_accuracy": 0.0,
    "heading": 0.0,
    "time": 0.0
  });

  RealDataSource() {
    getLocation();
  }

  Future<void> getLocation() async {
    locationData = await Location.instance.getLocation();
  }

  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final apiUrl = _getDailyApiCall(locationData, [
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
    final apiUrl = _getDailyApiCall(
        locationData, ['temperature_2m_max', 'temperature_2m_min']);
    final response = await http.get(apiUrl);
    return WeatherChartData.fromJson(jsonDecode(response.body));
  }

  @override
  Future<DailyForecastDto> getHourlyForecast(String dateString) async {
    final apiUrl = _getHourlyApiCall(locationData, dateString);
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return DailyForecastDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load hourly forecast');
    }
  }

  @override
  Future<CurrentWeatherDto> getCurrentWeather() async {
    final location = await Location.instance.getLocation();
    final apiUrl = _getCurrentWeatherApiCall(location);
    final response = await http.get(apiUrl);
    return CurrentWeatherDto.fromJson(jsonDecode(response.body));
  }
}

Uri _getDailyApiCall(LocationData locationData, List<String> variables) {
  return Uri.https("api.open-meteo.com", '/v1/forecast', {
    'latitude': '${locationData.latitude}',
    'longitude': '${locationData.longitude}',
    'daily': variables,
    'wind_speed_unit': 'ms',
    'timezone': 'Europe/Berlin',
  });
}

Uri _getHourlyApiCall(LocationData locationData, String dateString) {
  return Uri.https("api.open-meteo.com", '/v1/forecast', {
    'latitude': '${locationData.latitude}',
    'longitude': '${locationData.longitude}',
    'hourly': [
      'temperature_2m',
      'precipitation_probability',
      'weather_code',
      'wind_speed_10m',
    ],
    'wind_speed_10m': 'km/h',
    'timezone': 'Europe/Berlin',
    'start_date': dateString,
    'end_date': dateString
  });
}

Uri _getCurrentWeatherApiCall(LocationData locationData) {
  return Uri.https("api.open-meteo.com", '/v1/forecast', {
    'latitude': '${locationData.latitude}',
    'longitude': '${locationData.longitude}',
    'current': [
      'weather_code',
      'temperature_2m',
      'relative_humidity_2m',
      'precipitation',
      'wind_speed_10m',
      'wind_gusts_10m',
    ]
  });
}
