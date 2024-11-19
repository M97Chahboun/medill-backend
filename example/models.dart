import 'package:medill/medill.dart';

class Post extends BaseModel {
  MedillField id = MedillField();
  MedillField title = MedillField();
  MedillField content = MedillField();

  Post({required this.id, required this.title, required this.content});


  @override
  String get tableName => 'posts';

  @override
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }

  @override
  Post fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}


class MedillField{
  
}