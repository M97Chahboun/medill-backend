import 'dart:convert';
import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'extensions.dart';

abstract class Model {
  Model(this.table) {
    objects = Objects(table);
  }
  final String table;
  late Objects objects;

  Future<void> post(HttpRequest request) async {
    request.first.then((unites) {
      String data = utf8.decode(unites);
      var dataToJson = json.decode(data);
      objects.db
          .execute(fromParamsToSql(dataToJson, request.uri.path.substring(1)));
    });
    String table = routers.getModelByEndpoint(request.uri.path).objects.table;

    ResultSet select = objects.db.select("""SELECT * FROM $table""");
    request.response.write(select.toList());
    print("[POST]");
  }

  void get(HttpRequest request) {
    String table = routers.getModelByEndpoint(request.uri.path).objects.table;
    ResultSet select = objects.db.select("""SELECT * FROM $table""");
    request.response.write(select.toList());
    print("[GET]");
  }

  void put(Map data) {
    print("helllo put$data");
  }

  void del() {
    print("delete");
  }

  String fromParamsToSql(Map<String, dynamic> params, String table) {
    late String sql;
    String columns = "(";
    String values = "(";
    params.forEach((key, value) {
      columns += key;
      values += "'$value'";
    });
    columns += ")";
    values += ")";
    sql = """INSERT INTO $table $columns VALUES$values;""";
    return sql;
  }
}

class Objects {
  Objects(this.table) {    
    db = sqlite3.open(settings.dbPath!);
  }
  String table;
  late Database db;
  List get() {    
    return db.select("""SELECT * FROM $table""").toList();
  }
  //TODO:implements query methods
}
