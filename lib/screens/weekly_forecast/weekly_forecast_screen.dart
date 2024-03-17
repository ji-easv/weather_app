import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data_source.dart';
import 'package:weather_app/screens/shared.dart';

import '../../models/weekly_forecast.dart';
import '../../weather_sliver_app_bar.dart';
import 'weekly_forecast_list.dart';

class WeeklyForecastScreen extends StatefulWidget {
  const WeeklyForecastScreen({super.key});

  @override
  State<WeeklyForecastScreen> createState() => _WeeklyForecastScreenState();
}

class _WeeklyForecastScreenState extends State<WeeklyForecastScreen> {
  final controller = StreamController<WeeklyForecastDto>();

  @override
  void initState() {
    super.initState();
    loadForecast();
  }

  Future<void> loadForecast() async {
    final future = context.read<DataSource>().getWeeklyForecast();
    controller.addStream(future.asStream());
    await future;
  }

  @override
  Widget build(BuildContext context) {
    SharedUtilityComponents shared = SharedUtilityComponents();
    return RefreshIndicator.adaptive(
      onRefresh: loadForecast,
      child: StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) => CustomScrollView(
          slivers: <Widget>[
            const WeatherSliverAppBar(title: 'Weekly Forecast'),
            if (snapshot.hasData)
              WeeklyForecastList(weeklyForecastDto: snapshot.data!)
            else if (snapshot.hasError)
              shared.buildErrorWidget(context, snapshot.error!)
            else
              shared.buildLoadingWidget(context)
          ],
        ),
      ),
    );
  }
}
