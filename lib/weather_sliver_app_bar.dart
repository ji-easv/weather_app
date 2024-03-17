import 'package:flutter/material.dart';

class WeatherSliverAppBar extends StatelessWidget {
  final headerImageUrl =
      'https://images.unsplash.com/photo-1580193769210-b8d1c049a7d9?q=80&w=2348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  final String title;

  const WeatherSliverAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 100.0,
      backgroundColor: Theme.of(context).primaryColorDark,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        title: Text(title),
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          /* child: Image.network(
            headerImageUrl,
            fit: BoxFit.cover,
          ), */
        ),
      ),
    );
  }
}
