import '../orm/model.dart';

class User extends BaseModel {
  String id;
  String username;
  String passwordHash;

  User({required this.id, required this.username, required this.passwordHash});

  @override
  String get tableName => 'users';

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'passwordHash': passwordHash,
    };
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    passwordHash = map['passwordHash'];
  }

  static String _hashPassword(String password) {
    return password; // Placeholder for actual hashing
  }

  static Future<void> register(String username, String password) async {
    final hashedPassword = _hashPassword(password);
    final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        passwordHash: hashedPassword);
    await user.save();
  }

  static Future<User?> findByUsername(String username) async {
    // Simulate finding user
    return null; // This should implement actual logic to retrieve user
  }
}
