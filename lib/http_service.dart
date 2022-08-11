import 'package:dio/dio.dart';
import 'models/user.dart';

class HttpService {
  late Dio _dio;
  final baseUrl = "https://jsonplaceholder.typicode.com/";

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    initializeInterceptors();
  }

  Future<List<User>> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return (response.data as List).map((i) => User.fromJson(i)).toList();
  }


  initializeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          print("${options.method} ${options.path}");
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          // Do something with response data
          // print(response.data);
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          print(e.message);
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));
  }
}