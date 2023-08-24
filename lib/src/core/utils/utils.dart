import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:themebykarthi/themebykarthi.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await _openLocationSetting();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location disabled");
    }
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  print("getCurrentPosition");
  print(await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high));
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> _openLocationSetting() async {
  const AndroidIntent intent = AndroidIntent(
    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
  );
  await intent.launch();
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key, this.message = "Something went wrong !"})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KustomText(
        message,
      ),
    );
  }
}

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({Key? key, this.message = "No Records"})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KustomText(
        message,
      ),
    );
  }
}
