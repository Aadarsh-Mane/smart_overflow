# Smart Overflow

A comprehensive Flutter package for intelligent overflow detection and prevention.

## Features

- 🛡️ **Auto-detection**: Automatically detects potential overflow scenarios
- 🎯 **Smart strategies**: Multiple overflow handling strategies (wrap, scroll, scale, truncate)
- 🐛 **Debug tools**: Visual indicators for overflow detection during development
- ⚡ **Performance optimized**: Minimal impact on app performance
- 🎨 **Customizable**: Flexible configuration options

## Quick Start

```dart
import 'package:smart_overflow/smart_overflow.dart';

// Safe text that handles overflow automatically
SafeText(
  'Long text that might overflow',
  strategy: OverflowStrategy.scale,
)

// Safe row that prevents overflow
SafeRow(
  strategy: OverflowStrategy.wrap,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```
