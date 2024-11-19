import 'package:medill/src/core/middleware.dart';

class Context {
  final Request request;
  final Response response;

  Context(this.request, this.response);
}
