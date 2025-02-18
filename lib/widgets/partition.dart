import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class Partition extends StatelessWidget {
  final Widget child;
  final int flex;

  const Partition({
    Key? key,
    required this.child,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: child,
    );
  }
}

extension PartitionConverter on Partition {
  pw.Partition toPdfWidget(pw.Widget child) => pw.Partition(
        child: child as pw.SpanningWidget,
        flex: flex,
      );
}
