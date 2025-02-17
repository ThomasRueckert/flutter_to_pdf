import 'package:flutter/widgets.dart' show BoxDecoration, Container;

import 'package:flutter_to_pdf/args/alignment.dart';
import 'package:pdf/widgets.dart' as pw show Container, Widget;

import '../args/box_decoration.dart';
import '../args/color.dart';
import '../args/box_constraints.dart';
import '../args/edge_insets.dart';

/// Extension on [Container] to convert it to the pdf equivalent [pw.Container].
extension ContainerConverter on Container {
  /// Converts the [Container] to a [pw.Widget].
  Future<pw.Widget> toPdfWidget(pw.Widget? child) async {
    final pdfContainer = pw.Container(
      alignment: alignment?.toPdfAlignment(),
      decoration: await (decoration as BoxDecoration?)?.toPdfBoxDecoration(),
      color: color?.toPdfColor(),
      constraints: constraints?.toPdfBoxConstraints(),
      foregroundDecoration:
          await (foregroundDecoration as BoxDecoration?)?.toPdfBoxDecoration(),
      // Only set padding here (applied inside the container)
      padding: padding?.toPdfEdgeInsets(),
      transform: transform,
      child: child,
    );

    // Wrap the container with a Padding widget if margin is provided
    if (margin != null) {
      return pw.Padding(
        padding: margin!.toPdfEdgeInsets(),
        child: pdfContainer,
      );
    }
    return pdfContainer;
  }
}
