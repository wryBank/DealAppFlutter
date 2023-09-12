abstract class SignInEvent{
  const SignInEvent();
}

class EmailEvent extends SignInEvent{
  final String email;
  const EmailEvent(this.email);
}
class passwordEvent extends SignInEvent{
  final String password;
  const passwordEvent(this.password);
}
class usernameEvent extends SignInEvent{
  final String username;
  const usernameEvent(this.username);
}