import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/utils/utils.dart';
import '../../repo/home_repository.dart';
import '../../models/home/currentwheather_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  double? lat;
  double? long;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      try {
        emit(HomeLoading());
        Position pos = await determinePosition();
        lat = pos.latitude;
        long = pos.longitude;
        if (isClosed) return;
        Response response =
            await repository.getHomeData(lat: lat!, long: long!);

        if (response.statusCode == 200) {
          final weatherData = CurrentLocWheather.fromJson(response.data);
          emit(HomeSuccess(weatherData, weatherData.name!));
        }
      } on Exception catch (e) {
        HomeFailed(e.toString());
      }
    });
  }

  // @override
  // Stream<HomeState> mapEventToState(HomeEvent event) async* {
  //   if (event is GetHomeData) {
  //     yield* _mapGetHomeDataEventToState(event);
  //   }
  //   if (event is LocationError) {
  //     yield* _mapLocationNotEnabledToState(event);
  //   }
  // }

  // _mapLocationNotEnabledToState(LocationError event) async* {
  //   yield HomeLocationNotEnabled(event.error);
  // }

  // _mapGetHomeDataEventToState(GetHomeData event) async* {
  //   yield HomeLoading();
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble('lat', event.lat);
  //   prefs.setDouble('long', event.long);
  //   // try {
  //   print("event.lat");
  //   print("event.long");
  //   print(event.lat);
  //   print(event.long);

  //   Response response =
  //       await _repository.getHomeData(lat: event.lat, long: event.long);
  //   Response gRes =
  //       await _repository.getLocationName(lat: event.lat, long: event.long);
  //   // print(response.data);
  //   if (response.statusCode == 200) {
  //     final weatherData = WeatherData.fromJson(response.data);

  //     final place =
  //         gRes.data['results'][0]["address_components"][1]["long_name"];

  //     yield HomeSuccess(weatherData, place);
  //   } else {
  //     yield HomeFailed(response.data['message']);
  //   }
  //   // } catch (e) {
  //   //   yield HomeFailed(e.toString());
  //   // }
  // }

  // void getLocation() async {
  //   try {
  //     print("pos");
  //     print("pos");
  //     print("pos");

  //     Position pos = await determinePosition();
  //     print("pos");
  //     print("pos");
  //     print("pos");
  //     print(pos.latitude);
  //     print(pos);
  //     print(pos.longitude);
  //     lat = pos.latitude;
  //     long = pos.longitude;
  //     add(GetHomeData(lat: lat!, long: long!));
  //   } catch (err) {
  //     // showSnackBar(context, err.toString());
  //     // add(LocationError(err.toString()));
  //   }
  // }
}
