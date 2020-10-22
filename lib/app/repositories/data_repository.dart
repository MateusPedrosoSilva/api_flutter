import 'package:api_flutter/app/services/api.dart';
import 'package:api_flutter/app/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;
  String _accessToken;

  DataRepository({@required this.apiService});

  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken == null)
        _accessToken = await apiService.getAccessToken();
      return await apiService.getEndPointData(
          accessToken: _accessToken, endpoint: endpoint);
    } on Response catch (response) {
      // unathorized, get the token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndPointData(
            accessToken: _accessToken, endpoint: endpoint);
      }
      rethrow;
    }
  }
}
