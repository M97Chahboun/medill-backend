typedef Middleware = Future<void> Function(Request request, Response response);

class MiddlewareStack {
  final List<Middleware> _middlewares = [];

  void add(Middleware middleware) {
    _middlewares.add(middleware);
  }

  Future<void> run(Request request, Response response) async {
    for (var middleware in _middlewares) {
      await middleware(request, response);
    }
  }
}

class Request {
  final String method;
  final String path;

  Request(this.method, this.path);
}

class Response {
  int statusCode = 200;
  String body = '';

  void send(String message) {
    body = message;
    print('Response: $body (Status: $statusCode)');
  }
}
