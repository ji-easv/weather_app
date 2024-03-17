import 'dart:async';

import 'package:flutter/material.dart';

import '../../frontend_constants.dart';
import '../../models/current_weather_dto.dart';
import '../../models/weekly_forecast.dart';
import 'shared.dart';

class CurrentAndDailyOverview extends StatelessWidget {
  final StreamController<CurrentWeatherDto> currentWeatherController;
  final ForecastForOneDay weeklyForecastForThisDay;
  const CurrentAndDailyOverview(
      {super.key,
      required this.currentWeatherController,
      required this.weeklyForecastForThisDay});

  @override
  Widget build(BuildContext context) {
    final SharedUtilityComponents shared = SharedUtilityComponents();
    return StreamBuilder(
      stream: currentWeatherController.stream,
      builder: (context, snapshot) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 60),
              Text('City Name',
                  style: Theme.of(context).textTheme.headlineLarge),
              Text(
                weeklyForecastForThisDay.time!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              shared.spacer(),
              _buildFirstRow(context, snapshot.data),
              shared.spacer(),
              _buildDailyOverview(context, snapshot.data),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstRow(
      BuildContext context, CurrentWeatherDto? currentWeather) {
    final SharedUtilityComponents shared = SharedUtilityComponents();
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
                shared.darkText(
                    '${weeklyForecastForThisDay.temperature2MMax}°C', context),
                shared.divider(),
                shared.darkText(
                    '${weeklyForecastForThisDay.temperature2MMin}°C', context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyOverview(
      BuildContext context, CurrentWeatherDto? currentWeatherDto) {
    final SharedUtilityComponents shared = SharedUtilityComponents();
    Current? current = currentWeatherDto?.current;
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
                shared.textWithIcon(
                    shared.extractTimeOutOfISODateString(
                        weeklyForecastForThisDay.sunrise!),
                    DailyForecastIcons.sunrise,
                    context,
                    50),
                shared.textWithIcon(
                    shared.extractTimeOutOfISODateString(
                        weeklyForecastForThisDay.sunset!),
                    DailyForecastIcons.sunset,
                    context,
                    50),
              ],
            ),
            shared.spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shared.darkText("${current?.windSpeed10M} km/h", context),
                      shared.divider(),
                      shared.darkText("${current?.windGusts10M} km/h", context),
                    ],
                  ),
                ),
                const Expanded(child: Row()),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      shared.darkText("${current?.precipitation} mm", context),
                      shared.divider(),
                      shared.darkText(
                          "${current?.relativeHumidity2M} %", context),
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
}