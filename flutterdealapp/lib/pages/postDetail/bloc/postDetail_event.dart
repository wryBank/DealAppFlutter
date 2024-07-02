
import 'package:flutter/material.dart';

@immutable
abstract class PostDetailEvent {
  const PostDetailEvent();
}
class clickButton extends PostDetailEvent {
  String postId;
  final bool isReceived;
  String uidPostby;
  bool isFindJob;
  clickButton({required this.postId, required this.isReceived, required this.uidPostby, required this.isFindJob});
}
class clickButton2 extends PostDetailEvent {
  String postId;
  final bool isGave;
  String uidtakeby;
  bool isFindJob;
  clickButton2({required this.postId, required this.isGave, required this.uidtakeby, required this.isFindJob});
}