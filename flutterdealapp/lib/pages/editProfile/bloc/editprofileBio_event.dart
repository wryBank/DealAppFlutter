abstract class EditProfileBioEvent{
  const EditProfileBioEvent();
}

class BioEvent extends EditProfileBioEvent{
  final String bio;
  const BioEvent(this.bio);
}
