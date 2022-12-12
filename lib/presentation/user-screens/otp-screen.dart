import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business-logic/cubit-user/user_cubit.dart';
import '../../business-logic/cubit-user/user_state.dart';
import '../resource/colors-manager.dart';
import '../resource/routes_manager.dart';
import '../resource/strings-manager.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  void functionLoading(context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primaryColor),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  final phoneNumber;

  late String otpCode;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.verifyNumber,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
                text: StringsManager.writeCode,
                style:
                    TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
                children: <TextSpan>[
                  TextSpan(
                      text: '$phoneNumber',
                      style: TextStyle(color: ColorManager.primaryColor))
                ]),
          ),
        ),
      ],
    );
  }

  Widget buildinCodeFields(BuildContext context) {
    return Container(
        child: PinCodeTextField(
      length: 6,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      appContext: context,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: ColorManager.colorOtp,
          borderWidth: 1,
          activeColor: ColorManager.primaryColor,
          inactiveColor: ColorManager.primaryColor,
          inactiveFillColor: Colors.white,
          selectedColor: ColorManager.primaryColor,
          selectedFillColor: Colors.white),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (code) {
        otpCode = code;
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
    ));
  }

  void login(context) {
    BlocProvider.of<UserCubit>(context).submitOTP(otpCode);
  }

  Widget buildVrifyButton(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(110, 50),
            primary: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        onPressed: () {
          functionLoading(context);

          login(context);
        },
        child: Text(
          'Verify',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          functionLoading(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            Routes.homeLayoutScreen,
          );
        }

        if (state is ErrorOccurred) {
          String errorMsg = (state).error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              errorMsg,
            ),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: ColorManager.primaryColor,
                  height: size.height * 0.3,
                  width: double.infinity,
                  child: Container(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animation-file/OTP.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 32),
                  child: Column(
                    children: [
                      _buildIntroTexts(),
                      SizedBox(
                        height: 25,
                      ),
                      buildinCodeFields(context),
                      SizedBox(
                        height: 30,
                      ),
                      buildVrifyButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
