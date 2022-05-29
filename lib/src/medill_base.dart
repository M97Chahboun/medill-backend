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
      } else if (path == "/") {
        req.response.headers.contentType = ContentType.html;
        req.response.write(htmlCode(routers.routers.keys.toList(), port));
      } else {
        req.response.write("Not found");
      }

      await req.response.close();
    }
  }
}

htmlCode(List endpoints, int port) {
  String first = """
<!DOCTYPE html>
<html>
<body>
""";
  String buttons = "";
  for (var key in endpoints) {
    buttons += """
<h1>$key</h1>

<a type="button" href="http://localhost:$port$key">$key</a>
""";
  }
  String end = """ 
</body>
</html>
""";
  return first + buttons + end;
}
