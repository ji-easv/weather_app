import 'package:flutter/material.dart';
import 'package:weather_app/models.dart';

import 'server.dart';

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecastDto;

  const WeeklyForecastList({super.key, required this.weeklyForecastDto});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Daily weeklyForecast = weeklyForecastDto.daily!;
          return Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: <Color>[
                              Colors.grey[800]!,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1709603945846-6901ed447ecd?q=80&w=2429&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Text(
                          weeklyForecast.time?.elementAt(index) ?? 'Date',
                          style: textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Monday',
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(WeatherCode.fromInt(
                                weeklyForecast.weatherCode?.elementAt(index) ??
                                    0)
                            .description),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${weeklyForecast.temperature2MMax!.elementAt(index)} | ${weeklyForecast.temperature2MMin!.elementAt(index)} F',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 7,
      ),
    );
  }
}
