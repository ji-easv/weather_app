import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/daily_forecast_dto.dart';

import '../../data_source.dart';
import '../../frontend_constants.dart';

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
                    _buildDailyOverview(context),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildHourlyForecast(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyOverview(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Colors.grey[200]),
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _darkText('Sunrise', context),
                _darkText('Sunset', context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _darkText('Wind km/h', context),
                    _darkText('Gusts km/h', context),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _darkText('Precipation', context),
                    _darkText('Humidity', context),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFirstRow(BuildContext context) {
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
            Text('Max', style: Theme.of(context).textTheme.bodyMedium),
            Text('Min', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Text _darkText(String text, BuildContext context) {
    return Text(
      text,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
    );
  }

  Widget _buildHourlyForecast(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          _buildHourlyForecastItem(context),
          _buildHourlyForecastItem(context),
          _buildHourlyForecastItem(context),
        ],
      ),
    );
  }

  Widget _buildHourlyForecastItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _darkText('12:00', context),
        _textWithIcon('45%', DailyForecastIcons.rainChance, context, 25),
        _textWithIcon('7 km/h', DailyForecastIcons.wind, context, 25),
        _textWithIcon('26', DailyForecastIcons.placeholder, context, 50)
      ],
    );
  }

  Widget _textWithIcon(
      String text, String iconUrl, BuildContext context, double iconSize) {
    return Row(
      children: [
        SizedBox(
          height: iconSize,
          width: iconSize,
          child: Image.network(iconUrl),
        ),
        _darkText(text, context),
      ],
    );
  }
}
