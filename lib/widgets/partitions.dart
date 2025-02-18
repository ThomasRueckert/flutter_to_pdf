import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class Partitions extends StatelessWidget {
  final List<Widget> children;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final TextBaseline? textBaseline;
  final bool isPartition;

  const Partitions({
    super.key,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.textBaseline,
    this.isPartition = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      textBaseline: textBaseline,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

extension PartitionsConverter on Partitions {
  pw.Partitions toPdfWidget(List<pw.Widget> children) {
    final pw.Row row = children[0] as pw.Row;
    final List<pw.Widget> rowChildren = row.children;
    final List<pw.Partition> partitionChildren = rowChildren.map((child) {
      if (child is! pw.Partition) {
        throw Exception('Children of Partitions must be Partition widgets');
      }
      return child;
    }).toList();
    return pw.Partitions(
      mainAxisSize: mainAxisSize.toPdfMainAxisSize(),
      children: partitionChildren,
    );
  }
}

extension FlutterMainAxisSizeExtension on MainAxisSize {
  pw.MainAxisSize toPdfMainAxisSize() {
    switch (this) {
      case MainAxisSize.max:
        return pw.MainAxisSize.max;
      case MainAxisSize.min:
        return pw.MainAxisSize.min;
    }
  }
}
