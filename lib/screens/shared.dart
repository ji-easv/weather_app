import 'package:flutter/material.dart';

import '../frontend_constants.dart';

class SharedUtilityComponents {
  Divider divider() {
    return const Divider(
      color: Colors.black,
      thickness: 2,
      height: 10,
    );
  }

  Text darkText(String? text, BuildContext context) {
    return Text(
      text ?? '-',
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
    );
  }

  Widget textWithIcon(
      String text, String iconUrl, BuildContext context, double iconSize) {
    return Row(
      children: [
        SizedBox(
          height: iconSize,
          width: iconSize,
          child: Image.network(iconUrl),
        ),
        darkText(text, context),
      ],
    );
  }

  Widget spacer() {
    return const SizedBox(
      height: 16,
    );
  }

  String extractTimeOutOfISODateString(String? dateString) {
    if (dateString == null) {
      return '--:--';
    }
    return dateString.substring(11, 16);
  }

  Widget buildErrorWidget(BuildContext context, Object error) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Error loading forecast: $error',
          style: TextStyle(
              fontSize: 24, color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }

  Widget buildLoadingWidget(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  BoxDecoration getCardDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12, // this is a very light shadow
          blurRadius: 5, // this is the spread of the shadow
          offset: Offset(0, 0), // this is the position of the shadow
        ),
      ],
    );
  }

  String getImageUrlByWeatherCode(int weatherCode) {
    String url = '';
    switch (weatherCode) {
      // Clear
      case 0:
        url = WeatherCodeImages.clear;
        break;

      // Mainly clear, partly cloudy
      case 1:
      case 2:
        url = WeatherCodeImages.partlyCloudy;
        break;

      // Overcast
      case 3:
        url = WeatherCodeImages.overcast;
        break;

      // Fog
      case 45:
      case 48:
        url = WeatherCodeImages.fog;
        break;

      // Drizzle
      case 51:
      case 53:
      case 55:
      // Freezing drizzle
      case 56:
      case 57:
        url = WeatherCodeImages.drizzle;
        break;

      // Rain slight and moderate intensity
      case 61:
      case 63:
      case 80:
      case 81:
        url = WeatherCodeImages.slightModerateRain;
        break;

      // Rain heavy intensity and freezing rain
      case 65:
      case 66:
      case 82:
        url = WeatherCodeImages.heavyRain;
        break;

      // Snow
      case 71:
      case 73:
      case 75:
      case 77:
        url = WeatherCodeImages.snow;
        break;

      // Thunderstorm
      case 95:
      case 96:
      case 99:
        url = WeatherCodeImages.thunderstorm;
        break;
    }
    return url;
  }
}
