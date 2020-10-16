import 'dart:convert';
import 'dart:io';

import 'package:epicture/imgur/exception.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class ImgurClient {
  static final String id = "a22753f6afe846f";
  static final String host = "api.imgur.com";

  static Future<String> login() {
    final Uri requestUri = _uri("/oauth2/authorize", {
      "client_id": id,
      "response_type": "token",
    });

    return FlutterWebAuth.authenticate(
      url: requestUri.toString(),
      callbackUrlScheme: "fr.bonnetmathieux.epicture",
    );
  }

  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic> queryParameters,
    String token,
  }) {
    return _request(
      endpoint: endpoint,
      queryParameters: queryParameters,
      function: ({headers, uri}) {
        return http.delete(uri, headers: headers);
      },
      token: token,
    );
  }

  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic> queryParameters,
    String token,
  }) {
    return _request(
      endpoint: endpoint,
      queryParameters: queryParameters,
      function: ({headers, uri}) {
        return http.get(uri, headers: headers);
      },
      token: token,
    );
  }

  static Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> body,
    String token,
  }) {
    return _request(
      endpoint: endpoint,
      queryParameters: queryParameters,
      function: ({headers, uri}) {
        return http.post(uri, headers: headers, body: body);
      },
      token: token,
    );
  }

  static Future<Map<String, dynamic>> postMultipart(
    String endpoint, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> body,
    String field,
    File file,
    String token,
  }) {
    return _request(
      endpoint: endpoint,
      queryParameters: queryParameters,
      function: ({headers, uri}) async {
        final fileBytes = await file.readAsBytes();
        final request = http.MultipartRequest("POST", uri);

        request.headers.addAll(headers);
        request.fields.addAll(body);
        request.files.add(http.MultipartFile.fromBytes(field, fileBytes));

        final streamedResponse = await request.send();

        return http.Response.fromStream(streamedResponse);
      },
      token: token,
    );
  }

  static Future<Map<String, dynamic>> _request({
    String endpoint,
    Map<String, dynamic> queryParameters,
    Future<http.Response> function({
      Uri uri,
      Map<String, dynamic> headers,
    }),
    String token,
  }) async {
    try {
      final http.Response response = await function(
        uri: _uri(endpoint, queryParameters),
        headers: _headers(token),
      );

      return _decode(response);
    } on SocketException {
      throw ImgurSocketException("No internet connection");
    }
  }

  static Uri _uri(String endpoint, Map<String, dynamic> queryParameters) {
    return Uri.https(
      host,
      endpoint,
      queryParameters,
    );
  }

  static Map<String, String> _headers(String token) {
    return {
      "authorization": (token != null)
          ? "Bearer $token"
          : "Client-ID $id",
    };
  }

  static Map<String, String> _decode(http.Response response) {
    final Map<String, String> json = jsonDecode(
      utf8.decode(response.bodyBytes),
    );

    switch (response.statusCode) {
      case 200:
        return json;
      case 400:
        throw ImgurBadRequestException(json["error"]);
      case 401:
        throw ImgurUnauthorisedException(json["error"]);
      case 403:
        throw ImgurForbiddenException(json["error"]);
      case 404:
        throw ImgurNotFoundException(json["error"]);
      default:
        throw ImgurException(json["error"]);
    }
  }
}
