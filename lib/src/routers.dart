import 'model.dart';

class Routers {
    static final Routers _routers = Routers._internal();

  Map<String, Model> routers = {};
  void register(String endpoint, Model model) {
    routers[endpoint] = model;
  }

  Model getModelByEndpoint(String endpoint) => routers[endpoint]!;

  


  factory Routers() {
    return _routers;
  }
  Routers._internal();
}

