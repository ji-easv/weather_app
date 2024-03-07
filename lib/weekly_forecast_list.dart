import 'package:flutter/material.dart';
import 'package:weather_app/models.dart';

import 'server.dart';

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
          return Card(
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
                    '${weeklyForecast.temperature2MMax!.elementAt(index)} | ${weeklyForecast.temperature2MMin!.elementAt(index)} C',
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

  Widget _buildImageOverlay(
      BuildContext context, TextTheme textTheme, int index) {
    final imageSize = MediaQuery.of(context).size.width * 0.3;
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: _getImageByWeatherCode(
          weeklyForecastDto.daily!.weatherCode!.elementAt(index)),
      /* child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[Colors.grey[800]!, Colors.transparent],
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

  Image _getImageByWeatherCode(int weatherCode) {
    String url = '';
    switch (weatherCode) {
      // Clear
      case 0:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-01-1024.png';
        break;

      // Mainly clear, partly cloudy
      case 1:
      case 2:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-02-512.png';
        break;
      // Overcast
      case 3:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-22-512.png';
        break;

      // Fog
      case 45:
      case 48:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-27-1024.png';
        break;

      // Drizzle
      case 51:
      case 53:
      case 55:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-30-512.png';
        break;

      // Freezing drizzle
      case 56:
      case 57:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-30-512.png';
        break;

      // Rain slight and moderate intensity
      case 61:
      case 63:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-31-512.png';
        break;

      // Rain heavy intensity and freezing rain
      case 65:
      case 66:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-32-512.png';
        break;

      // Snow
      case 71:
      case 73:
      case 75:
      case 77:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-24-1024.png';
        break;

      // Thunderstorm
      case 95:
      case 96:
      case 99:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-08-1024.png';
        break;

      default:
        url =
            'https://cdn2.iconfinder.com/data/icons/weather-color-2/500/weather-02-512.png';
    }
    return Image.network(url, fit: BoxFit.cover);
  }
}
