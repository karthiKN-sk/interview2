import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview2/src/bloc/home_bloc/home_bloc.dart';
import 'package:interview2/src/repo/home_repository.dart';

import '../src/app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) =>
              HomeBloc(HomeRepository())..add(const LoadHomeData()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
