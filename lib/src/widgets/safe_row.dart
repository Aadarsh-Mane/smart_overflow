import 'package:flutter/material.dart';
import '../core/overflow_config.dart';

class SafeRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final OverflowStrategy? strategy;
  final OverflowConfig? config;

  const SafeRow({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.strategy,
    this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveConfig = config ?? OverflowConfig();
        final effectiveStrategy = strategy ?? effectiveConfig.defaultStrategy;

        // Detect potential overflow
        final totalWidth = _estimateChildrenWidth(constraints);
        final willOverflow = totalWidth > constraints.maxWidth;

        if (!willOverflow) {
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          );
        }

        return _buildSafeRow(effectiveStrategy, effectiveConfig);
      },
    );
  }

  Widget _buildSafeRow(OverflowStrategy strategy, OverflowConfig config) {
    switch (strategy) {
      case OverflowStrategy.wrap:
        return Wrap(
          children: children,
        );

      case OverflowStrategy.scroll:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        );

      case OverflowStrategy.flexible:
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children.map((child) => Flexible(child: child)).toList(),
        );

      default:
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
    }
  }

  double _estimateChildrenWidth(BoxConstraints constraints) {
    // Simplified estimation - in real implementation, measure each child
    return children.length * 100.0; // Placeholder
  }
}
