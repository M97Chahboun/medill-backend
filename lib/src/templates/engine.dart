import 'loaders.dart';

class TemplateEngine {
  final TemplateLoader loader;

  TemplateEngine(this.loader);

  Future<String> render(String templateName, Map<String, dynamic> context) async {
    // Load the template content
    final String template = await loader.load(templateName);
    
    // Render the template with the provided context
    return _renderTemplate(template, context);
  }

  String _renderTemplate(String template, Map<String, dynamic> context) {
    var rendered = template;

    // Simple placeholder replacement logic
    context.forEach((key, value) {
      rendered = rendered.replaceAll('{{ $key }}', value.toString());
    });

    return rendered;
  }
}