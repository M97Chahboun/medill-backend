import 'dart:io';
import 'package:medill/src/core/routing.dart';
import 'package:medill/src/migrate.dart';

class Medill {
  Medill(this.getRouters, this.setSettings,
      [this.ip = "localhost", this.port = 8085]);
  String ip;
  int port;
  final Router Function() getRouters;
  final Function setSettings;
  Future<void> run() async {
    setSettings();
    final routers = getRouters();
    // MigrateDb().migrate();

    var server = await HttpServer.bind(ip, port);
    print("[Start Medill Server] in http://$ip:$port");
    await for (HttpRequest req in server) {
      req.response.headers.contentType = ContentType.html;
      req.response.write(await routers.handleRequest(req));
      await req.response.close();
    }
  }
}
