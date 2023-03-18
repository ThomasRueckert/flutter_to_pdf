import 'package:flutter/material.dart' show TextField;

import 'package:pdf/pdf.dart' show PdfColors, PdfFieldFlags;
import 'package:pdf/widgets.dart' as pw show TextField, Text, Widget, Container, EdgeInsets, Stack, Positioned, Transform, Alignment, StackFit;

import '../traversal.dart';
import '/args/text_style.dart';
import '/args/input_decoration.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';


extension TextFieldConverter on TextField {
  Future<pw.Widget> toPdfWidget(ExportDelegate delegate) async {
    pw.Widget? label;

    if (decoration?.label != null) {
      // final List<pw.Widget> labelChildren = await delegate.matchWidget(
      //   decoration!.label!.createElement());
      final pw.Widget? labelWidget = await delegate.exportToPdfWidget(decoration!.label!);

      if (labelWidget != null) {
        label = pw.Transform.scale(
          scale: 0.6,
          child: pw.Container(
            color: PdfColors.white,
            padding: const pw.EdgeInsets.symmetric(horizontal: 2.0),
            // child: labelChildren.first,
            child: labelWidget,
          ),
        );
      }
    }

    return pw.Stack(
      alignment: pw.Alignment.center,
      fit: pw.StackFit.passthrough,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(4.0),
          margin: const pw.EdgeInsets.all(8.0),
          decoration: !delegate.options.textFieldOptions.ignoreDecoration
              ? decoration?.border?.toPdfInputBorder()
              : null,
          child: delegate.options.textFieldOptions.interactive ? pw.TextField(
            width: double.infinity,
            name: hashCode.toString(),
            defaultValue: controller?.value.text,
            textStyle: (delegate.options.textFieldOptions.getTextStyle(key) ?? style)?.toPdfTextStyle(), // TODO textStyle not applied within pdf package
            maxLength: maxLength,
            fieldFlags: { // TODO flags not applied by pdf package
              if (maxLines != null && maxLines! > 1) PdfFieldFlags.multiline,
              if (obscureText) PdfFieldFlags.password,
            },
          ) : pw.Text(
            controller?.value.text ?? '',
            maxLines: maxLines,
            textAlign: textAlign.toPdfTextAlign(),
            textDirection: textDirection?.toPdfTextDirection(),
            style: (delegate.options.textFieldOptions.getTextStyle(key) ?? style)?.toPdfTextStyle(),
          ),
        ),
        if (label != null) pw.Positioned(
          left: 10.0,
          top: 0.0,
          child: label,
        ),
      ],
    );
  }
}
