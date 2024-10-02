
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/App_URL.dart';

class AuthRepository {

  BaseapiServices _apiServices = NetworkApiservices();


  Future<dynamic> LoginAPi(dynamic data,) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    try {
      dynamic response = await _apiServices.getPostApiresponse(
          APPURl.LoginUrl, data,headers);

      return response;

    }
    catch (e) {
      throw e;
    }
  }

  Future<dynamic> SyncSmsAPI(dynamic data,  ) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    try {
      dynamic response = await _apiServices.getPostApiresponse(APPURl.HomeScreen, data, headers);
      return response;
    } catch (e) {
      throw e;
    }
  }


//ALL Mesgs
  Future ALlMESGS() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      // Just pass the URL for GET requests without a body
      dynamic response = await _apiServices.getGetApiresponse(APPURl.getALLMesg,headers);
      print(response);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

//ALL Device
  Future ALlDevices() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      // Just pass the URL for GET requests without a body
      dynamic response = await _apiServices.getGetApiresponse(APPURl.getALLDevices,headers);
      print(response);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
