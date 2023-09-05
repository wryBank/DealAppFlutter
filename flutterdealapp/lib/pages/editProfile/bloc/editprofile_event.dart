import 'package:equatable/equatable.dart';
abstract class EditProfileEvent {
  const EditProfileEvent();
  
}
// class Create extends EditProfileEvent{
//   final String uid;
//   final String username;
//   final int gender;
//   final String phonenumber;
//   final String urlprofileimage;
//   final String bio;
//   final int dealcount;
//   final int dealsucceed;
//   final int ondeal;
//   Create(this.uid,this.username,this.gender,this.phonenumber,this.urlprofileimage,this.bio,this.dealcount,this.dealsucceed,this.ondeal);
// }
class uidEvent extends EditProfileEvent{
  final String uid;
  const uidEvent(this.uid);
}
class usernameEvent extends EditProfileEvent{
  final String username;
  const usernameEvent(this.username);
}
class genderEvent extends EditProfileEvent{
  final int gender;
  const genderEvent(this.gender);
}
class phonenumberEvent extends EditProfileEvent{
  final String phonenumber;
  const phonenumberEvent(this.phonenumber);
}
class urlprofileimageEvent extends EditProfileEvent{
  final String urlprofileimage;
  const urlprofileimageEvent(this.urlprofileimage);
}
class bioEvent extends EditProfileEvent{
  final String bio;
  const bioEvent(this.bio);
}
class dealcountEvent extends EditProfileEvent{
  final int dealcount;
  const dealcountEvent(this.dealcount);
}
class dealsucceedEvent extends EditProfileEvent{
  final int dealsucceed;
  const dealsucceedEvent(this.dealsucceed); 
}
class ondealEvent extends EditProfileEvent{
  final int ondeal;
  const ondealEvent(this.ondeal); 
}