import 'dart:convert';
import 'dart:developer';

import 'package:medill/medill.dart';
import 'package:sqlite3/sqlite3.dart';

import 'routers.dart';
import 'settings.dart';

main(List<String> args) {
  Medill app = Medill(setRouters, setSettings);
  app.run();
}
