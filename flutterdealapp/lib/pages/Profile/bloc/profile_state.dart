part of 'profile_bloc.dart';

class ProfileState  {
}

class InitialState extends ProfileState{

}
class LoadingState extends ProfileState{
}
class getDataState extends ProfileState{
  final UserModel? userModel;
  getDataState(this.userModel);

}