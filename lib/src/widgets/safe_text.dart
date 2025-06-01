import 'package:flutter/material.dart';
import '../core/overflow_detector.dart';
import '../core/overflow_config.dart';

class SafeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final OverflowStrategy? strategy;
  final OverflowConfig? config;

  const SafeText(
    this.text, {
    Key? key,
    this.style,
    this.maxLines,
    this.overflow,
    this.strategy,
    this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveConfig = config ?? OverflowConfig();
        final effectiveStrategy = strategy ?? effectiveConfig.defaultStrategy;

        final willOverflow = OverflowDetector.detectTextOverflow(
          text,
          style ?? DefaultTextStyle.of(context).style,
          constraints,
          maxLines: maxLines,
        );

        if (!willOverflow) {
          return Text(
            text,
            style: style,
            maxLines: maxLines,
            overflow: overflow,
          );
        }

        return _buildOverflowSafeWidget(
          context,
          constraints,
          effectiveStrategy,
          effectiveConfig,
        );
      },
    );
  }

  Widget _buildOverflowSafeWidget(
    BuildContext context,
    BoxConstraints constraints,
    OverflowStrategy strategy,
    OverflowConfig config,
  ) {
    switch (strategy) {
      case OverflowStrategy.scale:
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(text, style: style, maxLines: maxLines),
        );

      case OverflowStrategy.scroll:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(text, style: style, maxLines: maxLines),
        );

      case OverflowStrategy.truncate:
        return Text(
          text,
          style: style,
          maxLines: maxLines ?? 1,
          overflow: TextOverflow.ellipsis,
        );

      case OverflowStrategy.wrap:
        return Text(
          text,
          style: style,
          overflow: TextOverflow.visible,
        );

      default:
        return Text(
          text,
          style: style,
          maxLines: maxLines,
          overflow: overflow ?? TextOverflow.ellipsis,
        );
    }
  }
}
