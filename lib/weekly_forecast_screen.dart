import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data_source.dart';

import 'weather_sliver_app_bar.dart';
import 'weekly_forecast_list.dart';

class WeeklyForecastScreen extends StatelessWidget {
  const WeeklyForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<DataSource>().getWeeklyForecast(),
      builder: (context, snapshot) => CustomScrollView(
        slivers: <Widget>[
          const WeatherSliverAppBar(),
          if (snapshot.hasData)
            WeeklyForecastList(weeklyForecastDto: snapshot.data!)
          else if (snapshot.hasError)
            _buildErrorWidget(context, snapshot.error!)
          else
            _buildLoadingWidget(context)
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error) {
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

  Widget _buildLoadingWidget(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
