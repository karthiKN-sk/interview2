import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themebykarthi/themebykarthi.dart';

class SplashImageScreen extends StatefulWidget {
  const SplashImageScreen({super.key});

  @override
  State<SplashImageScreen> createState() => _SplashImageScreenState();
}

class _SplashImageScreenState extends State<SplashImageScreen> {
  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    navigation();
  }

  navigation() {
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushNamed(context, "/bottom"),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Container(
      height: AppSize.screenHeight,
      width: AppSize.screenWidth,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: NetworkImage(
                "https://plus.unsplash.com/premium_photo-1669809948017-518b5d800d73?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8d2VhdGhlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
            fit: BoxFit.cover),
        color: themeData.colorScheme.background,
      ),
      child: Center(
        child: Column(
          children: [
            verticalSpace(AppSize.s120!),
            KustomText.headlineLarge(
              "Wheather App",
              color: themeData.colorScheme.background,
            ),
          ],
        ),
      ),
    );
  }
}
