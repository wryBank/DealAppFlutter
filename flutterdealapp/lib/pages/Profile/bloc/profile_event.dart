part of 'profile_bloc.dart';
@immutable
abstract class ProfileEvent  {
}
class getUserData extends ProfileEvent {
  String? uid;
  getUserData({required this.uid});
}