class GenderState {
  final String Gender;
  const GenderState({this.Gender = ""});
  GenderState copyWith({String? Gender}) {
    return GenderState(
      Gender: Gender ?? this.Gender,
    );
  }
}
