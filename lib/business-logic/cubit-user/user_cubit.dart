
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/business-logic/cubit-user/user_state.dart';


import '../../presentation/resource/constants-manager.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: timeoutProcessInFirebase),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verification Is Completed');
    await loginByMobileNumber(credential);
  }

  verificationFailed(FirebaseAuthException error) {
    print('verification Is Failed');
    print(error.toString());
    emit(ErrorOccurred(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('code is sent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmit());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);
    await loginByMobileNumber(credential);
  }

  Future<void> loginByMobileNumber(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      print(error.toString());
      emit(ErrorOccurred(error.toString()));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
