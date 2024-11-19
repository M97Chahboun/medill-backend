import 'dart:io';

abstract class TemplateLoader {
  Future<String> load(String templateName);
}

class FileTemplateLoader implements TemplateLoader {
  final String templatesDirectory;

  FileTemplateLoader(this.templatesDirectory);

  @override
  Future<String> load(String templateName) async {
    final filePath = '$templatesDirectory/$templateName';
    final file = File(filePath);

    if (await file.exists()) {
      return await file.readAsString();
    } else {
      throw Exception('Template $templateName not found at $filePath');
    }
  }
}
