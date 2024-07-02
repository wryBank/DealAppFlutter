
class postDetailState{

}
class postDetailInitial extends postDetailState{}
class clickPostState extends postDetailState{
  final bool isClickReceived;
  clickPostState({required this.isClickReceived});
}
class clickPostState2 extends postDetailState{
  final bool isGraveClicked;
  clickPostState2({required this.isGraveClicked});
}