import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview2/src/views/home/widgets/weather_detail_widget.dart';
import 'package:themebykarthi/themebykarthi.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../../core/constants/image_const.dart';

import '../../core/utils/utils.dart';
import '../../models/home/currentwheather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refresh() async {
    context.read<HomeBloc>().add(const LoadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Loading();
          }
          if (state is HomeSuccess) {
            final weather = state.weatherData;
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                await _refresh();
                // BlocProvider.of<HomeBloc>(context).add(const LoadHomeData());
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CurrentWeather(place: state.place, weather: weather),
                    WeatherDetailsWidget(curWeather: weather),
                    verticalSpace(AppSize.s16!),
                    KustomContainer(
                      padding: EdgeInsets.symmetric(horizontal: AppSize.s16!),
                      alignment: Alignment.topLeft,
                      child: KustomText.bodyLarge(
                        "24 Hours",
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is HomeFailed) {
            return SomethingWentWrong(message: state.error);
          }
          if (state is HomeLocationNotEnabled) {
            if (state.error == "Location disabled") {
              return const Center(
                child: KustomText.labelLarge(
                  'Location services are disabled.\nPlease Restart app after enabling it.',
                ),
              );
            }
            return SomethingWentWrong(message: state.error);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    Key? key,
    required this.place,
    required this.weather,
  }) : super(key: key);

  final String place;
  final CurrentLocWheather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: AppSize.screenWidth,
      child: Stack(
        children: [
          Positioned(
            top: -AppSize.screenWidth * 0.23,
            right: -AppSize.screenWidth * 0.35,
            child: Image.network(
              ImageAssets.getAsset(weather.weather!.first.icon!),
              height: AppSize.screenHeight * 0.45,
            ),
          ),
          Container(
            width: AppSize.screenWidth * 0.55,
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.screenWidth * 0.08,
                vertical: AppSize.screenHeight * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KustomText.displayMedium(
                  place,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(color: theme.colorScheme.secondary),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(AppSize.s8!),
                KustomText.displayMedium('${weather.main!.temp!}°',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: AppSize.s30,
                      color: theme.colorScheme.tertiary,
                    )),
                verticalSpace(AppSize.s16!),
                WeatherTypeChip(title: weather.weather!.first.main!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherTypeChip extends StatelessWidget {
  const WeatherTypeChip({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return KustomContainer(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.s24!, vertical: AppSize.s12!),
      color: theme.colorScheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(AppSize.s25!),
      child: KustomText.displayMedium(
        title,
        style: theme.textTheme.titleMedium
            ?.copyWith(color: theme.colorScheme.onTertiaryContainer),
        textAlign: TextAlign.center,
      ),
    );
  }
}
