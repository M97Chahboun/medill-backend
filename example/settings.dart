import 'dart:io';

import 'package:medill/medill.dart';

void setSettings() {
  Settings settings = Settings();
  settings.dbPath = Directory.current.path + "/example" + "/apidb.sqlite3";
}
