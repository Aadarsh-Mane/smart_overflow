import 'package:flutter/material.dart';

enum OverflowStrategy {
  wrap,
  scroll,
  scale,
  truncate,
  flexible,
  none,
}

enum OverflowDetectionMode {
  buildTime,
  layoutTime,
  runtime,
}

class OverflowConfig {
  final OverflowStrategy defaultStrategy;
  final bool enableDebugMode;
  final Color debugColor;
  final double debugOpacity;
  final OverflowDetectionMode detectionMode;
  final Duration animationDuration;
  final bool enablePerformanceMode;

  const OverflowConfig({
    this.defaultStrategy = OverflowStrategy.flexible,
    this.enableDebugMode = false,
    this.debugColor = Colors.red,
    this.debugOpacity = 0.3,
    this.detectionMode = OverflowDetectionMode.layoutTime,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enablePerformanceMode = true,
  });
}
