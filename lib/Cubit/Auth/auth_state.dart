part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class SignedOutState extends AuthState {
  const SignedOutState();
}

class ProcessingState extends AuthState {
  const ProcessingState();
}

class SignInErrorState extends AuthState {
  final String message;
  const SignInErrorState(this.message);
}

class SignedInState extends AuthState {
  const SignedInState();
}
