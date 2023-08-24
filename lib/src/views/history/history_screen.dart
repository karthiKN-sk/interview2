import 'package:flutter/material.dart';
import 'package:themebykarthi/themebykarthi.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            KustomContainer(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s20!, vertical: AppSize.s16!),
              alignment: Alignment.topLeft,
              child: KustomText.displaySmall(
                "History of\n5 Previous Days",
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
