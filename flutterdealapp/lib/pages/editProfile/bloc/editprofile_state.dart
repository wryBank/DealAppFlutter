class EditProfileState {
  final String uid;
  final String username;
  final int gender;
  final String phonenumber;
  final String urlprofileimage;
  final String bio;
  final int dealcount;
  final int dealsucceed;
  final int ondeal;
  const EditProfileState({this.uid="",this.username="",this.gender=0,this.phonenumber="",
  this.urlprofileimage="",this.bio="",this.dealcount=0,this.dealsucceed=0,this.ondeal=0});

  EditProfileState copyWith({
    String? uid, String? username, int? gender, String? phonenumber, String? urlprofileimage,
    String? bio, int? dealcount, int? dealsucceed, int? ondeal}){
      return EditProfileState(uid: uid??this.uid,username: username??this.username,
      gender: gender??this.gender,phonenumber: phonenumber??this.phonenumber,urlprofileimage: urlprofileimage??this.urlprofileimage,
      bio: bio??this.bio,dealcount: dealcount??this.dealcount,dealsucceed: dealsucceed??this.dealsucceed,
      ondeal: ondeal??this.ondeal);
    }
  
}

class ProfileAdding extends EditProfileState{

}

class ProfileAdded extends EditProfileState{

}
class ProfileError extends EditProfileState{

}