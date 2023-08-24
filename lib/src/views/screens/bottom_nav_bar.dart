import 'package:flutter/material.dart';

import '../features/search_screen.dart';
import '../history/history_screen.dart';
import '../home/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    SearchScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all<TextStyle>(
              theme.textTheme.titleSmall!.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
            indicatorColor: theme.colorScheme.onSecondary,
            iconTheme: MaterialStateProperty.all<IconThemeData>(
              IconThemeData(
                color: theme.colorScheme.onBackground,
              ),
            ),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          ),
          child: NavigationBar(
            backgroundColor: theme.colorScheme.secondary,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  selectedIcon: Icon(
                    Icons.home_rounded,
                  ),
                  label: "Home"),
              NavigationDestination(
                  icon: Icon(
                    Icons.search_outlined,
                  ),
                  selectedIcon: Icon(
                    Icons.search_rounded,
                  ),
                  label: "Search"),
              NavigationDestination(
                  icon: Icon(
                    Icons.book_outlined,
                  ),
                  selectedIcon: Icon(
                    Icons.book_rounded,
                  ),
                  label: "History"),
            ],
          ),
        ),
      ),
    );
  }
}
