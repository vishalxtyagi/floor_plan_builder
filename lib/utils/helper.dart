import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class AppHelper {
  static Future<String> coloredSvg(String svgPath,
      {required Color color}) async {
    // Load the SVG file
    final svgContent = await rootBundle.loadString(svgPath);

    // Parse the SVG content
    final document = XmlDocument.parse(svgContent);

    // Find the last element node
    final lastElement =
        document.rootElement.children.whereType<XmlElement>().last;

    // Change the color of the last layer
    lastElement.setAttribute('fill', colorToHex(color));

    // Return the modified SVG content
    return document.toXmlString();
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}
