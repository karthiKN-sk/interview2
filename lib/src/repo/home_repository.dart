import '../core/constants/app_constants.dart';
import '../core/network/api_base_helper.dart';
import '../core/utils/secrets.dart';

class HomeRepository {
  HomeRepository();
  final _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> getHomeData({
    required double lat,
    required double long,
  }) async {
    final path = "$baseUrl/weather?lat=$lat&lon=$long&appid=$apiKey";
    final response = await _apiBaseHelper.get(path);
    return response;
  }
}
