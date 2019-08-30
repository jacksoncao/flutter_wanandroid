import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:convert';
import '../utils/storage_utils.dart';

class NetUtils{

  static Dio _dio = Dio();

  static init() async{
    _dio.options.connectTimeout = 10000; //10秒超时时间
    _dio.options.sendTimeout = 10000; //10秒超时时间
    _dio.options.followRedirects = true; //允许重定向操作
    _dio.options.maxRedirects = 3; //最多重定向3次
    _dio.interceptors.add(LogInterceptor()); //添加日志拦截器
    //设置cookie的持久化到磁盘上的路径
    String cookiePath = await StorageUtils.getCookieFilePath();
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: cookiePath)));
    //Flutter设置网络代理  使用Fildder抓包
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   // config the http client  
    //   client.findProxy = (uri) {
    //       //proxy all request to localhost:8888
    //       return "PROXY 10.100.11.103:8888";
    //   };
    //   //抓Https包设置
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // };
  }

  //get请求数据
  static Future<Map<String,dynamic>> get(String url) async{
    Response response = await _dio.request<String>(url);
    print("====>网络层请求结果码code:${response.statusCode}");
    return json.decode(response.data);
  }

  //post请求数据
  static Future<Map<String,dynamic>> post(String url,{Map<String,String> params}) async {
    Response response = await _dio.post<String>(
      url,
      data:params,
      options: Options(
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
      )
    );
    print("====>网络层请求结果码code:${response.statusCode}===>${response.data.toString()}");
    return json.decode(response.data);
  }

}