import 'package:flutter/material.dart';
import 'package:themebykarthi/themebykarthi.dart';

import '../../core/constants/image_const.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: theme.colorScheme.secondary,
        title: SizedBox(
          width: AppSize.screenWidth * 0.7,
          child: TextField(
            controller: _searchController,
            style:
                KustomTextStyle.bodyMedium(color: theme.colorScheme.onTertiary),
            onSubmitted: (value) {},
            decoration: InputDecoration(
              hintText: 'Search City',
              hintStyle: KustomTextStyle.bodyMedium(fontSize: AppSize.s18),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search_rounded,
                size: AppSize.s28,
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              key: const ValueKey('refresh'),
              onPressed: () {},
              icon: Icon(
                Icons.refresh,
                size: AppSize.s28,
                color: theme.colorScheme.onTertiary,
              ))
        ],
      ),
      body: Container(
        height: AppSize.screenHeight * 0.8,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              ImageAssets.getAsset('02d'),
              height: AppSize.screenHeight * 0.25,
              fit: BoxFit.fill,
            ),
            verticalSpace(AppSize.s10!),
            KustomText(
              'Search the weather \nof the city you want !',
              textAlign: TextAlign.center,
              style: KustomTextStyle.bodyMedium(
                  fontSize: AppSize.s28,
                  fontWeight: 700,
                  color: theme.colorScheme.onTertiaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
