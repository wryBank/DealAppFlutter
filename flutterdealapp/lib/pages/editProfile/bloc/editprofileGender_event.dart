abstract class EditProfileGenderEvent{
  const EditProfileGenderEvent();
}

class GenderEvent extends EditProfileGenderEvent{
  final String Gender;
  const GenderEvent(this.Gender);
}
