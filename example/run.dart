import 'package:medill/medill.dart';

import 'routers.dart';
import 'settings.dart';

main(List<String> args) {
  Medill app = Medill(setRouters, setSettings);
  app.run();
}
