import 'package:medill/medill.dart';

import 'models.dart';

Router setRouters() {
  Router routers = Router();
  routers.addRoute("/endpoint", (request) async {
    if (request.method == "GET") {
      return htmlCode([request.uri]);
    } else if (request.method == "POST") {
      final post1 = Post.fromMap(await request.body);
      await post1.save();
      return "Item Added";
    } else {
      return "Invalid Method";
    }
  });
  return routers;
}

htmlCode(List endpoints) {
  String first = """
<!DOCTYPE html>
<html>
<body>
""";
  String buttons = "";
  for (var url in endpoints) {
    buttons += """
<h1>$url</h1>

<a type="button" href="$url">$url</a>
""";
  }
  String end = """
</body>
</html>
""";
  return first + buttons + end;
}
