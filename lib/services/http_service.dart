import 'package:dio/dio.dart';

class HttpService {
  late Dio dio;
  final baseUrl = "https://jsonplaceholder.typicode.com/";

  HttpService() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    initializeInterceptors();
  }

  initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
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
