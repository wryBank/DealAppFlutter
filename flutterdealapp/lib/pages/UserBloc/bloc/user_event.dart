part of 'user_bloc.dart';

@immutable
abstract class UserEvent  {
}
class getUser extends UserEvent {
  UserModel userModel;
  getUser({required this.userModel});
}
class getUserByUid extends UserEvent {
  String uid;
  getUserByUid({required this.uid});
}