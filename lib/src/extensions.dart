import 'dart:convert';
import 'dart:io';

import 'package:medill/src/migrate.dart';

import '../medill.dart';

extension Url on Medill {
  Routers get routers => Routers();
}

extension UrlsModel on Model {
  Routers get routers => Routers();
}

extension Setting on Object {
  Settings get settings => Settings();
}

extension SettingMig on MigrateDb {
  Settings get settings => Settings();
  Routers get routers => Routers();
}

extension RequestExtenions on HttpRequest {
  get body async {
    var bodyBytes = await single;
    String requestBody = utf8.decode(bodyBytes);
    final jsonBody = json.decode(requestBody);
    return jsonBody;
  }
}
