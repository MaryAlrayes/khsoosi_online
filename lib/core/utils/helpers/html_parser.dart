import 'package:html/parser.dart';

class CustomHtmlParser {
  static String parseHtml(String html) {
    return parse(
      html,
    ).body!.text;
  }
}
