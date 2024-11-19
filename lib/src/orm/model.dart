import 'query.dart';

abstract class BaseModel {
  late final query = Query(this);
  // Define the table name for the model
  String get tableName;

  // Save the model to the database
  Future<void> save() async {
    await query.insert();
  }

  // Convert the model to a map representation for database operations
  Map<String, dynamic> toMap();

  // Load a model from a map representation
  void fromMap(Map<String, dynamic> map);
}
