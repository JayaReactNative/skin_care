import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import '../dependency_injection.dart';

class Auth {
  static Future<dynamic> get(String url, {required bool needToken}) async {
    log("get call: ${url}");
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        var headers = {
          'Content-Type': 'application/json',
          'token': needToken ? storage.read("token") as String : "",
        };
        // final response = await http.get(Uri.parse(url));
        var request = http.Request('GET', Uri.parse(url));

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          return jsonDecode(await response.stream.bytesToString());
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  static Future<dynamic> postBody(String url, dynamic body,
      {required bool needToken}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        // print("$body");
        // print("$url");

    log("post call: ${url} $body");
        var headers = {
          'Content-Type': 'application/json',
          'token': needToken ? storage.read("token") as String : "",
        };
        var request = http.Request('POST', Uri.parse(url));
        request.body = json.encode(body);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          return jsonDecode(await response.stream.bytesToString());
        } else {
          throw Exception('Failed to post data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to the server');
    }
  }

  static Future<dynamic> postFormData(
      String url, Map<String, String> data) async {
    try {
    log("form-data call: ${url} $data");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        final response = await http.post(Uri.parse(url), body: data);
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed to post form data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
