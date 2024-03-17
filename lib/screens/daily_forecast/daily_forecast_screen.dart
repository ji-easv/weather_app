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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 60),
                    Text('City Name',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.dateString,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    _buildFirstRow(context),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildFirstRow(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                                'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-01-1024.png'),
                          ),
                          Text(
                            '26',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Max',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text('Min',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  );
  }
}
