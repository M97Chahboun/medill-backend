import 'dart:developer';
import 'dart:io';
import 'dart:mirrors';

import 'extensions.dart';
import 'migrate.dart';
import 'model.dart';

class Medill {
  Medill(this.setRouters, this.setSettings,
      [this.ip = "localhost", this.port = 8085]);
  String ip;
  int port;
  final Function setRouters;
  final Function setSettings;
  Future<void> run() async {
    setSettings();
    setRouters();
    MigrateDb().migrate();

    var server = await HttpServer.bind(ip, port);
    log("[Start Medill Server]");
    log("Available routers :");
    for (String endpoint in routers.routers.keys) {
      log("http://localhost:$port$endpoint");
    }
    await for (HttpRequest req in server) {
      String path = req.uri.path;
      if (routers.routers.keys.contains(path) && !path.contains(".")) {
        Model model = routers.getModelByEndpoint(path);
        var ref = reflect(model);
        String method = req.method.toLowerCase();
        ref.invoke(Symbol(method), [req]);
      } else {
        req.response.write("Not found");
      }

      await req.response.close();
    }
  }
}
