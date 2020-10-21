import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class APIService {
  final API api;

  APIService(this.api);

  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKeys}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
      'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
    );
    throw response;
  }

  Future<int> getEndPointData({
    @required String accessToken,
    @required Endpoint endpoint,
  }) async {
    final uri = api.endPointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int result = endpointData[responseJsonKey];
        if (result != null) {
          return result;
        }
      }
    }
    print(
      'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
    );
    throw response;
  }
}
