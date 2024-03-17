import 'package:flutter/material.dart';
import 'package:weather_app/models/models.dart';

import '../../models/weekly_forecast.dart';
import '../daily_forecast/daily_forecast_screen.dart';
import '../shared.dart';

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecastDto;

  const WeeklyForecastList({super.key, required this.weeklyForecastDto});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Daily weeklyForecast = weeklyForecastDto.daily!;
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DailyForecastScreen(
                  weeklyForecastForThisDay:
                      weeklyForecastDto.dailyForecast.elementAt(index),
                ),
              ));
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12, // this is a very light shadow
                    blurRadius: 2, // this is the spread of the shadow
                    offset: Offset(0, 0), // this is the position of the shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  _buildImageOverlay(context, textTheme, index),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _weekdayAsString(
                              DateTime.parse(
                                weeklyForecast.time!.elementAt(index),
                              ),
                            ),
                            style: textTheme.headlineSmall,
                          ),
                          Text(weeklyForecast.time!.elementAt(index)),
                          const SizedBox(height: 10.0),
                          Text(WeatherCode.fromInt(weeklyForecast.weatherCode
                                      ?.elementAt(index) ??
                                  0)
                              .description),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${weeklyForecast.temperature2MMax!.elementAt(index)} | ${weeklyForecast.temperature2MMin!.elementAt(index)} C',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 7,
      ),
    );
  }

  Widget _buildImageOverlay(
      BuildContext context, TextTheme textTheme, int index) {
    final imageSize = MediaQuery.of(context).size.width * 0.20;
    final SharedUtilityComponents shared = SharedUtilityComponents();
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: Image.network(
          shared.getImageUrlByWeatherCode(
              weeklyForecastDto.daily!.weatherCode!.elementAt(index)),
          fit: BoxFit.cover),
      /* child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[Colors.grey[300]!, Colors.transparent],
              ),
            ),
            child: _getImageByWeatherCode(
              weeklyForecastDto.daily!.weatherCode!.elementAt(index),
            ),
          ),
          Center(
            child: Text(
              '',
              style: textTheme.displayMedium,
            ),
          ),
        ],
      ),*/
    );
  }

  String _weekdayAsString(DateTime time) {
    return switch (time.weekday) {
      DateTime.monday => 'Monday',
      DateTime.tuesday => 'Tuesday',
      DateTime.wednesday => 'Wednesday',
      DateTime.thursday => 'Thursday',
      DateTime.friday => 'Friday',
      DateTime.saturday => 'Saturday',
      DateTime.sunday => 'Sunday',
      _ => ''
    };
  }
}
