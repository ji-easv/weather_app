import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data_source.dart';
import 'package:weather_app/screens/daily_forecast/daily_forecast_screen.dart';

import 'weather_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<DataSource>(
          create: (context) => FakeDataSource(),
        ),
      ],
      child: const WeatherApp(),
    ),
  );
}
