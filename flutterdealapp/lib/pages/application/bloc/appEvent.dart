import 'package:flutter/material.dart';
@immutable
abstract class AppEvent {}

class TapChange extends AppEvent {
  final int tabIndex;

  TapChange({required this.tabIndex});
}