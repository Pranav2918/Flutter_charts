import 'dart:math';
import 'package:charts_flutter/src/text_element.dart' as text_element;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/flutter.dart';

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  static String? value;

  CustomCircleSymbolRenderer();
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      Color? fillColor,
      FillPatternType? fillPattern,
      Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    canvas.drawRect(
        Rectangle(bounds.left - 10, bounds.top - 30, bounds.width + 40,
            bounds.height + 15),
        fill: Color.fromHex(code: '#05a3e8'));

    var textStyle = style.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 15;
    canvas.drawText(text_element.TextElement(value!, style: textStyle),
        (bounds.left - 5).round(), (bounds.top - 28).round());
  }
}
