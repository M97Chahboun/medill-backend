import 'model.dart';

class Query {
  final BaseModel model;

  Query(this.model);

  Future<void> insert() async {
    final data = model.toMap();
    // Here you would implement the actual database insertion logic
    print('Inserting data into ${model.tableName}: $data');
  }

  // Add more methods for querying, updating, and deleting
  Future<List<Map<String, dynamic>>> select() async {
    // Implement actual database select logic
    print('Selecting from ${model.tableName}');
    print('Fields : ${model.toMap().keys}');
    return []; // Placeholder return
  }
}
