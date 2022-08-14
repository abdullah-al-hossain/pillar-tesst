import 'package:api_call_dio/models/post.dart';
import 'package:api_call_dio/models/user.dart';
import 'package:api_call_dio/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DataProvider {
  HttpService httpService = HttpService();

  Future<List<Post>> getPost(String endPoint) async {
    Response response;
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

    Options _options = buildCacheOptions(Duration(days: 1));
    httpService.dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      response = await httpService.dio.get(endPoint, options: _options);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return (response.data as List).map((i) => Post.fromJson(i)).toList();
  }


  Future<List<User>> getUser(String endPoint) async {
    Response response;
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

    Options _options = buildCacheOptions(Duration(days: 1));
    httpService.dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      response = await httpService.dio.get(endPoint, options: _options);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return (response.data as List).map((i) => User.fromJson(i)).toList();
  }
}