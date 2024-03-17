import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/shared.dart';

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
            decoration: SharedUtilityComponents().getCardDecoration(),
            child: Column(
              children: snapshot.data?.forecastForOneHourList
                      .map((forecast) =>
                          _buildHourlyForecastItem(context, forecast))
                      .toList() ??
                  [],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyForecastItem(
      BuildContext context, ForecastForOneHour? forOneHour) {
    final SharedUtilityComponents shared = SharedUtilityComponents();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        shared.darkText(
            shared.extractTimeOutOfISODateString(forOneHour?.time), context),
        shared.textWithIcon("${forOneHour?.precipitationProbability}%",
            DailyForecastIcons.rainChance, context, 20),
        shared.textWithIcon("${forOneHour?.windSpeed10M} km/h",
            DailyForecastIcons.wind, context, 25),
        shared.textWithIcon(
            "${forOneHour?.temperature2M}°C",
            shared.getImageUrlByWeatherCode(forOneHour?.weatherCode ?? 0),
            context,
            40)
      ],
    );
  }
}
