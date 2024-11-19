class Settings {
  static final Map<String, dynamic> _settings = {};

  static void set(String key, dynamic value) {
    _settings[key] = value;
  }

  static dynamic get(String key) {
    return _settings[key];
  }

  static void load(Map<String, dynamic> settings) {
    _settings.addAll(settings);
  }
}
