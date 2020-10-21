import 'package:api_flutter/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class API {
  final String apiKeys;
  API({@required this.apiKeys});

  factory API.sandbox() => API(apiKeys: APIKeys.ncovSandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );
}
