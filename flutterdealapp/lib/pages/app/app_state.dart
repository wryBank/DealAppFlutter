class AppState {
  int counter;
  AppState({required this.counter});
}
class InitStates extends AppState{
  InitStates():super(counter: 0);
}