import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/daily_forecast_dto.dart';

import '../../data_source.dart';
import '../../frontend_constants.dart';
import '../../models/weekly_forecast.dart';

class DailyForecastScreen extends StatefulWidget {
  final ForecastForOneDay?
      weeklyForecastForThisDay; // comes from the weekly forecast
  const DailyForecastScreen(
      {super.key, required this.weeklyForecastForThisDay});

  @override
  State<DailyForecastScreen> createState() => _DailyForecastScreenState();
}

class _DailyForecastScreenState extends State<DailyForecastScreen> {
  final controller = StreamController<DailyForecastDto>();
  LocationData? location;

  Future<void> loadForecast() async {
    final future = context.read<DataSource>().getHourlyForecast(
        DateTime.parse(widget.weeklyForecastForThisDay!.time!));
    controller.addStream(future.asStream());
    await future;
    location = await Location.instance.getLocation();
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
                      widget.weeklyForecastForThisDay!.time!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    _spacer(),
                    _buildFirstRow(context, snapshot),
                    _spacer(),
                    _buildDailyOverview(context, snapshot.data),
                    _spacer(),
                    _buildHourlyForecast(context, snapshot),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyOverview(
      BuildContext context, DailyForecastDto? dailyForecast) {
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
                    _extractTimeOutOfISODateString(
                        widget.weeklyForecastForThisDay!.sunrise!),
                    DailyForecastIcons.sunrise,
                    context,
                    50),
                _textWithIcon(
                    _extractTimeOutOfISODateString(
                        widget.weeklyForecastForThisDay!.sunset!),
                    DailyForecastIcons.sunset,
                    context,
                    50),
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
                      _darkText("${"wind"} km/h", context),
                      _divider(),
                      _darkText("${"gusts"} km/h", context),
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

  Widget _buildFirstRow(
      BuildContext context, AsyncSnapshot<DailyForecastDto> snapshot) {
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
                _darkText(
                    '${widget.weeklyForecastForThisDay!.temperature2MMax}°C',
                    context),
                _divider(),
                _darkText(
                    '${widget.weeklyForecastForThisDay!.temperature2MMin}°C',
                    context),
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

  Widget _buildHourlyForecast(
      BuildContext context, AsyncSnapshot<DailyForecastDto> snapshot) {
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

  String _extractTimeOutOfISODateString(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.hour}:${date.minute}';
  }
}
