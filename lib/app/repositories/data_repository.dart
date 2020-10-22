import 'package:api_flutter/app/repositories/endpoints_data.dart';
import 'package:api_flutter/app/services/api.dart';
import 'package:api_flutter/app/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;
  String _accessToken;

  DataRepository({@required this.apiService});

  Future<int> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<int>(
        onGetData: () => apiService.getEndPointData(
            accessToken: _accessToken, endpoint: endpoint),
      );

  Future<EndpointsData> getAllEndpointData() async =>
      await _getDataRefreshingToken<EndpointsData>(
        onGetData: _getAllEndpointsData,
      );

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null)
        _accessToken = await apiService.getAccessToken();
      return await onGetData();
    } on Response catch (response) {
      // unathorized, get the token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.casesConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
