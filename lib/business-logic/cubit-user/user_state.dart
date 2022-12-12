abstract class UserState {}

class UserInitial extends UserState {}

class Loading extends UserState {}

class ErrorOccurred extends UserState {
  final String error;

  ErrorOccurred(this.error);
}

class PhoneNumberSubmit extends UserState {}

class PhoneOTPVerified extends UserState {}
