import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final double offsetX; // Horizontal offset
  final double offsetY; // Vertical offset

  CustomFABLocation(this.location, {this.offsetX = 0, this.offsetY = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Get the original offset
    final Offset originalOffset = location.getOffset(scaffoldGeometry);
    // Return new offset
    return Offset(originalOffset.dx + offsetX, originalOffset.dy - offsetY);
  }
}

// Usage in your Scaffold