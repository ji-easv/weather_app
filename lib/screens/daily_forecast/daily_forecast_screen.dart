import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/daily_forecast_dto.dart';

import '../../data_source.dart';

class DailyForecastScreen extends StatefulWidget {
  final String dateString;

  const DailyForecastScreen({super.key, required this.dateString});

  @override
  State<DailyForecastScreen> createState() => _DailyForecastScreenState();
}

class _DailyForecastScreenState extends State<DailyForecastScreen> {
  final controller = StreamController<DailyForecastDto>();

  Future<void> loadForecast() async {
    final future = context
        .read<DataSource>()
        .getDailyForecast(DateTime.parse(widget.dateString));
    controller.addStream(future.asStream());
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: loadForecast,
      child: StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) => CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Daily Forecast for ${widget.dateString}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
