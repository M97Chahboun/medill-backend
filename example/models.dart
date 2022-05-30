import 'package:medill/medill.dart';

class Developers extends Model {
  INTEGER? age;
  TEXT? language;
  Developers(super.table);
}

class Managers extends Model {
  TEXT? name;

  Managers(super.table);
}

class Seniors extends Model {
  INTEGER? years;
  TEXT? company;

  Seniors(super.table);
}
