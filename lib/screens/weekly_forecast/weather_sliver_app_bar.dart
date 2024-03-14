import 'package:flutter/material.dart';

class WeatherSliverAppBar extends StatelessWidget {
  final headerImageUrl =
      'https://images.unsplash.com/photo-1580193769210-b8d1c049a7d9?q=80&w=2348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  const WeatherSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).primaryColorDark,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        title: const Text('Weekly Forecast'),
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: <Color>[
                Theme.of(context).primaryColorDark,
                Colors.transparent
              ],
            ),
          ),
          child: Image.network(
            headerImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
