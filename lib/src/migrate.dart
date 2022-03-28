import 'package:medill/src/model.dart';
import 'extensions.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:mirrors';

class MigrateDb {
  void migrate() {
    final db = sqlite3.open(settings.dbPath!);
    Map<String, ModelTable> modelsAndFields = getModelsAndFields(Model);
    modelsAndFields.forEach((key, value) {
      String tableName = value.table;
      String sql = "CREATE TABLE $tableName ";
      String fields = "(\n";
      for (var e in value.fields) {
        String gum = value.fields.last == e ? "" : ",";
        fields += e["field"]! + " " + e["type"]! + gum;
      }
      fields += ");";
      sql += fields;
      try {
        db.execute(sql);
      } on SqliteException catch (er) {
        ResultSet table = db.select("SELECT * FROM $tableName");
        String alter = "ALTER TABLE $tableName ";
        value.fields.forEach((e) {
          String gum = value.fields.last == e ? ";" : ";";
          if (!table.columnNames.contains(e['field'])) {
            alter += "ADD COLUMN ${e['field']} ${e['type']}" + gum;
          }
        });
        if (alter.contains("ADD")) {
          db.execute(alter);
          print("Update: " + tableName);
        }
      }
    });
  }

  Map<String, ModelTable> getModelsAndFields(Type type) {
    Map<String, ModelTable> modelAndFields = {};
    ClassMirror classMirror = reflectClass(type);
    currentMirrorSystem()
        .libraries
        .values
        .expand((lib) => lib.declarations.values)
        .forEach((lib) {
      if (lib is ClassMirror &&
          lib.isSubclassOf(classMirror) &&
          lib != classMirror) {
        String model = lib.toString();
        String table = "";
        List<Map<String, String>> allFields = [];
        model = model.substring(16, model.length - 1);
        routers.routers.forEach((key, mdl) {
          if (mdl.runtimeType.toString() == model) table = mdl.table;
        });
        lib.instanceMembers.forEach((key, value) {
          if (value.isSynthetic &&
              value.simpleName != Symbol("objects") &&
              value.simpleName != #table) {
            String field = key.toString();
            field = field.substring(8, field.length - 2);
            if (!field.contains("=")) {
              String type = value.returnType.simpleName.toString();
              type = type.substring(8, type.length - 2);
              Map<String, String> fieldType = {"field": field, "type": type};
              allFields.add(fieldType);
            }
          }
        });

        modelAndFields[model] = ModelTable(allFields, table);
      }
    });
    return modelAndFields;
  }
}

class ModelTable {
  ModelTable(this.fields, this.table);
  List<Map<String, String>> fields;
  String table;
}


//  void migrate() {
//     Map<String, ModelTable>> modelsAndFields =
//         getModelsAndFields(Model);
//     modelsAndFields.forEach((key, value) {
//       try {
//         createTable(value, key);
//       } on SqliteException catch (er) {
//         print(er.message);
//         ResultSet table = db.select("SELECT * FROM $key");
//         String alter = "ALTER TABLE $key ";
//         String dropOrAdd =
//             value.length <= table.columnNames.length ? "DROP" : "ADD COLUMN";
//         value.forEach((e) {
//           String gum = value.last == e ? ";" : ";";
//           if (!table.columnNames.contains(e['field'])) {
//             alter += "$dropOrAdd ${e['field']} ${e['type']}" + gum;
//           }
//         });
//         print(alter);
//         if (alter.contains("DROP")) {
//           print('hhhhhhhhhhhhh');
//           db.execute(alter);
//           print("Update: " + key + dropOrAdd);
//         }
//       }
//     });
//   }