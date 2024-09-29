

abstract class BaseapiServices {

  Future<dynamic> getGetApiresponse (String url, Map<String,String> header,{Map<String,dynamic>? queryParameters });
  Future<dynamic> getPostApiresponse (String url,dynamic data,Map<String,String>header);
  Future<dynamic> getPatchApi (String url,dynamic data,Map<String,String>header);
  Future<dynamic> getPostApiresponseWithoutdata (String url,Map<String,String>header);
}