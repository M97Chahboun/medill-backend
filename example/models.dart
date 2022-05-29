import 'package:medill/medill.dart';

class Developers extends Model {
  INTEGER? age;
  TEXT? language;

  Developers(String table) : super(table);
}

class Managers extends Model {
  TEXT? name;

  Managers(String table) : super(table);
}

class Seniors extends Model {
  INTEGER? years;
  TEXT? company;

  Seniors(String table) : super(table);
}
