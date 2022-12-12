import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


import '../../business-logic/cubit-user/user_cubit.dart';
import '../../business-logic/cubit-user/user_state.dart';
import '../resource/colors-manager.dart';
import '../resource/routes_manager.dart';
import '../resource/strings-manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  late String phoneNumber;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.whatNumber,
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
          child: Text(
            StringsManager.requestNumber,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  void Login(context) {
    if (!_formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _formKey.currentState!.save();
      BlocProvider.of<UserCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  Widget buildNextButton(context) {
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
          Login(context);
        },
        child: Text(
          'Next',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.colorTextFormField,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Text(
                generateCountryFlag() + ' +20',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2.0,
                ),
              ),
            )),
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.colorTextFormField,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: TextFormField(
                autofocus: true,
                style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return StringsManager.validatePhoneNumberNotBeEmpty;
                  } else if (value.length < 11) {
                    return StringsManager.validateLengthPhoneNumber;
                  }
                },
                onSaved: (value) {
                  phoneNumber = value!;
                  print(value);
                },
              ),
            )),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Widget ?functionLoading(context) {
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
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

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
        if (state is PhoneNumberSubmit) {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.oTPScreen,
              arguments: phoneNumber);
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: ColorManager.primaryColor,
                  height: size.height * 0.3,
                  width: double.infinity,
                  child: Container(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animation-file/83548-online-shopping-black-friday.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildIntroTexts(),
                SizedBox(
                  height: 30,
                ),
                buildPhoneFormField(),
                SizedBox(
                  height: 30,
                ),
                buildNextButton(context),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
