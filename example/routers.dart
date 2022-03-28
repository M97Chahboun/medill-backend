import 'package:medill/medill.dart';

import 'models.dart';

void setRouters() {
  Routers routers = Routers();
  routers.register("/endpoint", Developers("developers"));
  routers.register("/managers", Managers("managers"));
  routers.register("/seniors", Seniors("seniors"));
}
