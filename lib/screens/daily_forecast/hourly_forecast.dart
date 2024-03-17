import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/daily_forecast/shared.dart';

import '../../frontend_constants.dart';
import '../../models/daily_forecast_dto.dart';

class HourlyForecastList extends StatelessWidget {
  final StreamController<DailyForecastDto> hourlyForecastController;
  const HourlyForecastList({super.key, required this.hourlyForecastController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: hourlyForecastController.stream,
      builder: (context, snapshot) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(18),
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
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyForecastItem(BuildContext context) {
    final SharedUtilityComponents shared = SharedUtilityComponents();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        shared.darkText('12:00', context),
        shared.textWithIcon('45%', DailyForecastIcons.rainChance, context, 25),
        shared.textWithIcon('7 km/h', DailyForecastIcons.wind, context, 25),
        shared.textWithIcon('26', DailyForecastIcons.placeholder, context, 50)
      ],
    );
  }
}
