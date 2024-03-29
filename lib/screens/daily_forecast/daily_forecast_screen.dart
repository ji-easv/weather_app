import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/current_weather_dto.dart';
import 'package:weather_app/models/daily_forecast_dto.dart';
import 'package:weather_app/screens/daily_forecast/current_and_daily_view.dart';
import 'package:weather_app/screens/daily_forecast/hourly_forecast.dart';

import '../../data_source.dart';
import '../../models/weekly_forecast.dart';
import '../../weather_sliver_app_bar.dart';

class DailyForecastScreen extends StatefulWidget {
  final ForecastForOneDay?
      weeklyForecastForThisDay; // comes from the weekly forecast
  const DailyForecastScreen(
      {super.key, required this.weeklyForecastForThisDay});

  @override
  State<DailyForecastScreen> createState() => _DailyForecastScreenState();
}

class _DailyForecastScreenState extends State<DailyForecastScreen> {
  final hourlyForecastController = StreamController<DailyForecastDto>();
  final currentWeatherController = StreamController<CurrentWeatherDto>();

  @override
  void initState() {
    super.initState();
    loadForecast();
  }

  Future<void> loadForecast() async {
    // Get the hourly forecast for the selected day
    final hourlyForecastFuture = context
        .read<DataSource>()
        .getHourlyForecast(widget.weeklyForecastForThisDay!.time!);

    // Get the current forecast
    final currentForecastFuture =
        context.read<DataSource>().getCurrentWeather();

    // Add both futures to the respective streams
    hourlyForecastController.addStream(hourlyForecastFuture.asStream());
    currentWeatherController.addStream(currentForecastFuture.asStream());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: loadForecast,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: CustomScrollView(
          slivers: [
            const WeatherSliverAppBar(title: 'Daily Forecast'),
            CurrentAndDailyOverview(
              currentWeatherController: currentWeatherController,
              weeklyForecastForThisDay: widget.weeklyForecastForThisDay!,
            ),
            HourlyForecastList(
              hourlyForecastController: hourlyForecastController,
            ),
          ],
        ),
      ),
    );
  }
}
