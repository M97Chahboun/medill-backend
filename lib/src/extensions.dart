import 'package:medill/src/migrate.dart';
import 'package:medill/src/routers.dart';
import 'package:medill/src/settings.dart';

import '../medill.dart';
import 'model.dart';

extension Url on Medill {
  Routers get routers => Routers();
}

extension UrlsModel on Model {
  Routers get routers => Routers();
}


extension Setting on Objects{
  Settings get settings => Settings();
}

extension SettingMig on MigrateDb {
  Settings get settings => Settings();
  Routers get routers => Routers();
}
