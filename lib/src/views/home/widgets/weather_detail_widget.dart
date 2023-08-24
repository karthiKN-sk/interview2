import 'package:flutter/material.dart';
import 'package:themebykarthi/themebykarthi.dart';

import '../../../models/home/currentwheather_model.dart';

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({
    Key? key,
    required this.curWeather,
  }) : super(key: key);

  final CurrentLocWheather curWeather;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding:  EdgeInsets.symmetric(horizontal: AppSize.s8!),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.7,
        crossAxisCount: 2,
      ),
      children: [
        HeadingDetailWidget(
          title: "Humidity",
          value: '${curWeather.main!.humidity!}',
          unit: '%',
        ),
        HeadingDetailWidget(
            title: "Wind Speed",
            value: '${curWeather.wind!.speed!}',
            unit: 'm/s'),
        HeadingDetailWidget(
            title: "Pressure",
            value: '${curWeather.main!.pressure}',
            unit: 'hPa'),
        HeadingDetailWidget(title: "UV", value: '${curWeather.cod}'),
        HeadingDetailWidget(
            title: "Visibility", value: '${curWeather.visibility}', unit: 'km'),
        HeadingDetailWidget(
            title: "Cloudiness", value: '${curWeather.clouds!.all}', unit: '%'),
      ],
    );
  }
}

class HeadingDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const HeadingDetailWidget({
    Key? key,
    required this.title,
    required this.value,
    this.unit = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return KustomContainer(
      padding:  EdgeInsets.symmetric(vertical: AppSize.s8!, horizontal: AppSize.s16!),
      margin:  EdgeInsets.all(AppSize.s8!),
      borderRadius: BorderRadius.circular(AppSize.s25!),
      color: theme.colorScheme.onSecondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: value,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
              ),
              TextSpan(
                text: ' $unit',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}
