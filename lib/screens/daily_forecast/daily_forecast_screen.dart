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
                    Text(
                      widget.dateString,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    _spacer(),
                    _buildFirstRow(context),
                    _spacer(),
                    _buildDailyOverview(context),
                    _spacer(),
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
        borderRadius: BorderRadius.circular(18),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _textWithIcon(
                    'Sunrise', DailyForecastIcons.sunrise, context, 50),
                _textWithIcon('Sunset', DailyForecastIcons.sunset, context, 50),
              ],
            ),
            _spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _darkText('Wind km/h', context),
                      _divider(),
                      _darkText('Gusts km/h', context),
                    ],
                  ),
                ),
                const Expanded(child: Row()),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _darkText('Precipation', context),
                      _divider(),
                      _darkText('Humidity', context),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFirstRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                      'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-01-1024.png'),
                ),
                Text(
                  '26',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                _darkText('Max', context),
                _divider(),
                _darkText('Min', context),
              ],
            ),
          ),
        ],
      ),
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

  Widget _spacer() {
    return const SizedBox(
      height: 16,
    );
  }

  Divider _divider() {
    return const Divider(
      color: Colors.black,
      thickness: 2,
      height: 10,
    );
  }
}
