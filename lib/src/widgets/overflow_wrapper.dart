import 'package:flutter/material.dart';
import 'package:smart_overflow/src/utils/debug_painter.dart';
import '../core/overflow_config.dart';

class OverflowWrapper extends StatefulWidget {
  final Widget child;
  final OverflowConfig config;
  final bool enableAutoDetection;

  const OverflowWrapper({
    Key? key,
    required this.child,
    this.config = const OverflowConfig(),
    this.enableAutoDetection = true,
  }) : super(key: key);

  @override
  State<OverflowWrapper> createState() => _OverflowWrapperState();
}

class _OverflowWrapperState extends State<OverflowWrapper> {
  bool _hasOverflow = false;
  final GlobalKey _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _checkForOverflow(constraints);
        });

        Widget child = Container(
          key: _childKey,
          child: widget.child,
        );

        if (widget.config.enableDebugMode && _hasOverflow) {
          child = Stack(
            children: [
              child,
              Positioned.fill(
                child: CustomPaint(
                  painter: OverflowDebugPainter(
                    color: widget.config.debugColor,
                    opacity: widget.config.debugOpacity,
                    showOverflow: _hasOverflow,
                  ),
                ),
              ),
            ],
          );
        }

        return child;
      },
    );
  }

  void _checkForOverflow(BoxConstraints constraints) {
    if (!widget.enableAutoDetection) return;

    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final hasOverflow = size.width > constraints.maxWidth ||
        size.height > constraints.maxHeight;

    if (hasOverflow != _hasOverflow) {
      setState(() {
        _hasOverflow = hasOverflow;
      });
    }
  }
}
