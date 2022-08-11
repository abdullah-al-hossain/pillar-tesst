import 'package:api_call_dio/models/post.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../models/user.dart';

class HttpService {
  late Dio _dio;
  final baseUrl = "https://jsonplaceholder.typicode.com/";

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    initializeInterceptors();
  }

  Future<List<Post>> getPost(String endPoint) async {
    Response response;
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

    Options _options = buildCacheOptions(Duration(days: 1));
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      response = await _dio.get(endPoint, options: _options);
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
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      response = await _dio.get(endPoint, options: _options);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return (response.data as List).map((i) => User.fromJson(i)).toList();
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("${options.method} ${options.path}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      print(response);
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print(e.message);
      return handler.next(e);
    }));
  }
}
