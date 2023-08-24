import 'package:flutter/material.dart';
import 'package:themebykarthi/themebykarthi.dart';

import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return MaterialApp(
      title: "OpenWheather App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      onGenerateRoute: routes,
      initialRoute: "/splash",
    );
  }
}
