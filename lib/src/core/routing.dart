import 'dart:core';
import 'dart:io';

class Route {
  final String path;
  final Function(HttpRequest request) handler;

  Route(this.path, this.handler);
}

class Router {
  final List<Route> _routes = [];

  void addRoute(String path, Function(HttpRequest request) handler) {
    _routes.add(Route(path, handler));
  }

   handleRequest(HttpRequest request) {
    for (var route in _routes) {
      if (route.path == request.uri.path) {
        return route.handler(request);
      }
    }
    return '404 Not Found';
  }

  List<Route> get routes => _routes;
}
