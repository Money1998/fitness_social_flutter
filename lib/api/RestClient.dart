import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/ResponseManager.dart';
import 'package:montage/api/WebUrl.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/utilites.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';

class RestClient {
  ApiCallBacks _apiCallBacks;

  RestClient(this._apiCallBacks);

  Future<dynamic> post(Map requestParam, String requestCode) async {
    print(requestParam);
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError(
          "Check your internet connection and try again", requestCode);
    } else {
      try {
        String url = WebUrl.MAIN_URL + requestCode;
        print(url);
        final response = await http
            .post(Uri.parse(url),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' +
                      await SessionManager.getStringData(ACCESS_TOKEN),
                },
                body: jsonEncode(requestParam))
            .timeout(Duration(seconds: 30));

        final responseBody = jsonDecode(response.body);
        print(responseBody);
        if (responseBody['statusCode'] == 200) {
            print("DAATATTATA");
            print("responseBody => $responseBody['data']");
          print(responseBody);
          var returnObject = ResponseManager.parser(requestCode, responseBody);
          _apiCallBacks.onSuccess(
              returnObject, responseBody['message'], requestCode);
          // } else {
          //   print("status == 0");
          //   _apiCallBacks.onError(responseBody["message"], requestCode);
          // }
        
        } else {
            print("da");
          _apiCallBacks.onError(responseBody['message'], requestCode);
        }
      } catch (e) {
        print(e);
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }

  Future<dynamic> postCount(Map requestParam, String requestCode) async {
    print(requestParam);
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError(
          "Check your internet connection and try again", requestCode);
    } else {
      try {
        String url = WebUrl.QUESTION_URL + requestCode;
        print(url);
        final response = await http
            .post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader: 'Bearer ' +
                  await SessionManager.getStringData(ACCESS_TOKEN),
            },
            body: jsonEncode(requestParam))
            .timeout(Duration(seconds: 30));

        final responseBody = jsonDecode(response.body);
        print(responseBody);
        if (response.statusCode == 200) {
          print("getCount Data => $responseBody");
        }
      } catch (e) {
        print(e);
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }

  Future<dynamic> put(Map requestParam, String requestCode) async {

    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError(
          "Check your internet connection and try again", requestCode);
    } else {
      try {
        String url = WebUrl.MAIN_URL + requestCode;
        print(url);
        final response = await http
            .put(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader: 'Bearer ' +
                  await SessionManager.getStringData(ACCESS_TOKEN),
            },
            body: jsonEncode(requestParam))
            .timeout(Duration(seconds: 30));

        final responseBody = jsonDecode(response.body);
        print(responseBody);
        if (responseBody['statusCode'] == 200) {
          print("DAATATTATA");
          print(responseBody);
          var returnObject = ResponseManager.parser(requestCode, responseBody);
          _apiCallBacks.onSuccess(
              returnObject, responseBody['message'], requestCode);
          // } else {
          //   print("status == 0");
          //   _apiCallBacks.onError(responseBody["message"], requestCode);
          // }

        } else {
          print("da");
          _apiCallBacks.onError(responseBody['message'], requestCode);
        }
      } catch (e) {
        print(e);
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }

  void postWithMultipart(
      File profileImage, Map requestParam, String requestCode) async {
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError("Internet is not connected", requestCode);
    } else {
      String url = WebUrl.MAIN_URL + requestCode;
      var uri = Uri.parse(url);
      var request = new http.MultipartRequest("POST", uri);

      if (profileImage != null) {
        var stream = new http.ByteStream(
            DelegatingStream.typed(profileImage.openRead()));
        var length = await profileImage.length();
      }
      // var multipartFile = new http.MultipartFile("media", stream, length,
      //      filename: basename(profileImage.path));
      //      request.files.add(multipartFile);
      request.fields.addAll(requestParam);
      // }
      try {
        var response = await request.send().timeout(Duration(seconds: 10));
        print(response.statusCode);
        response.stream.transform(utf8.decoder).listen((value) {
          final responseBody = json.decode(value);
          // final responseBody = jsonDecode(response.);
          print(responseBody);
          print(responseBody['statusCode']);
          if (responseBody['statusCode'] != 200) {
            _apiCallBacks.onError(responseBody['message'], requestCode);
          } else {
            print("DAATATTATA");
            print(responseBody);
            var returnObject =
                ResponseManager.parser(requestCode, responseBody);
            _apiCallBacks.onSuccess(
                returnObject, responseBody['message'], requestCode);
            // } else {
            //   print("status == 0");
            //   _apiCallBacks.onError(responseBody["message"], requestCode);
            // }
          }
          // if (response.statusCode != 200 && responseBody == null) {
          //   _apiCallBacks.onError(
          //       "An error occured Status Code : $response.status", requestCode);
          // } else {
          //   print(responseBody);
          //   print("RESPONSE BODY");
          //   if (responseBody["status"] == 1) {
          //     var returnObject =
          //         ResponseManager.parser(requestCode, responseBody);
          //     _apiCallBacks.onSuccess(
          //         returnObject, responseBody['message'], requestCode);
          //   } else {
          //     print("status == 0");
          //     _apiCallBacks.onError(responseBody["message"], requestCode);
          //   }
          // }
        });
      } on Exception catch (e) {
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }

  void uploadImage(
      File image, String type, String id, String requestCode) async {
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError("Internet is not connected", requestCode);
    } else {
      String url = WebUrl.MAIN_URL + requestCode;
      var uri = Uri.parse(url);
      var request = new http.MultipartRequest("POST", uri);
      print(request);
      Map<String, String> headers = {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await SessionManager.getStringData(ACCESS_TOKEN)
      };
      request.headers.addAll(headers);
      request.fields.addAll({'moduleId': id, 'type': type});
      print(image);
      if (image != null) {
        var stream =
            new http.ByteStream(DelegatingStream.typed(image.openRead()));
        var length = await image.length();
        var multipartFile = new http.MultipartFile("image", stream, length,
            filename: basename(image.path));
        request.files.add(multipartFile);
      }
      try {
        var response = await request.send().timeout(Duration(seconds: 20));

        response.stream.transform(utf8.decoder).listen((value) {
          final responseBody = json.decode(value);
          if (response.statusCode != 200 && responseBody == null) {
            _apiCallBacks.onError(
                "An error occured Status Code : $response.status", requestCode);
          } else {
            if (responseBody["status"] == 1) {
              var returnObject =
                  ResponseManager.parser(requestCode, responseBody);
              _apiCallBacks.onSuccess(
                  returnObject, responseBody['message'], requestCode);
            } else {
              print("status == 0");
              _apiCallBacks.onError(responseBody["message"], requestCode);
            }
          }
        });
      } on Exception catch (e) {
        print(e);
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }

  Future<dynamic> get(String requestCode) async {
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError(
          "Check your internet connection and try again", requestCode);
    } else {
      try {
        var url = WebUrl.MAIN_URL + requestCode;
        debugPrint(url);
        //String url = 'http://192.168.0.103:3000/' + requestCode;
        var response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
        var responseBody = json.decode(response.body);
        if (response.statusCode != 200 && responseBody == null) {
          _apiCallBacks.onError(
              "An error occured Status Code : $response.statusCode",
              requestCode);
        } else {
          if (responseBody["statusCode"] == 200) {
            var returnObject =
                ResponseManager.parser(requestCode, responseBody);
            _apiCallBacks.onSuccess(
                returnObject, responseBody['message'], requestCode);
          } else {
            print("status == 0");
            _apiCallBacks.onError(responseBody["message"], requestCode);
          }
        }
      } catch (e) {
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }



  Future<dynamic> delete(String requestCode) async {
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      _apiCallBacks.onConnectionError(
          "Check your internet connection and try again", requestCode);
    } else {
      try {
        String url = WebUrl.MAIN_URL + requestCode;
        debugPrint(url);
        //String url = 'http://192.168.0.103:3000/' + requestCode;
        final response = await http.delete(Uri.parse(url), headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).timeout(Duration(seconds: 10));
        final responseBody = json.decode(response.body);
        if (response.statusCode != 200 && responseBody == null) {
          _apiCallBacks.onError(
              "An error occured Status Code : $response.statusCode",
              requestCode);
        } else {
          if (responseBody["statusCode"] == 200) {
            var returnObject =
            ResponseManager.parser(requestCode, responseBody);
            _apiCallBacks.onSuccess(
                returnObject, responseBody['message'], requestCode);
          } else {
            print("status == 0");
            _apiCallBacks.onError(responseBody["message"], requestCode);
          }
        }
      } catch (e) {
        _apiCallBacks.onError("somthing went wrong try again...", requestCode);
      }
    }
  }

}
