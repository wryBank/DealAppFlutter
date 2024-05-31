
class BioState  {

  final String bio;
  const BioState({this.bio=""});
  BioState copyWith({String? bio}){
  return BioState(
    bio: bio??this.bio,
    
  );
  }
  
  
}