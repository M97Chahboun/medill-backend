class Settings {
  static final Settings _settings = Settings._internal();

  String? dbPath;
  factory Settings() {
    return _settings;
  }
  Settings._internal();
}
