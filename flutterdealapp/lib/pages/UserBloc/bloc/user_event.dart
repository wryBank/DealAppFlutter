part of 'user_bloc.dart';

@immutable
abstract class UserEvent  {
}
class getUser extends UserEvent {
  UserModel userModel;
  getUser({required this.userModel});
}