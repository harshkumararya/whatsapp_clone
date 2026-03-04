import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/pages/initialProfileSubmitPage.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      "Verify Your OTP ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Enter your OTP for the WhatsApp Clone Verification (so that you will be moved for the further steps to complete)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 30),
                  _pinCodeWidget(),
                  SizedBox(height: 10,),
                  Text("Enter your 6 digit code",style: TextStyle(fontSize: 16),),
                  SizedBox(height: 30),
                ],
              ),
            ),
             GestureDetector(
              onTap: _submitSmsCode,
            // onTap: (){
            //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>InitialProfileSubmitPage(phoneNumber: '',)));
            // },
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: tabColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text("Next",style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),
          )   
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidget() {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: tabColor, width: 2)),
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Pinput(
        length: 6,
        controller: _otpController,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => SizedBox(width: 8), //box k beech ka gap
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tabColor, width: 3.5)),
          ),
        ),
        onCompleted: (pin) {
          print("enter opt:${pin}");
          // firebase wala logic aayega
        },
      ),
    );
  }

   void _submitSmsCode(){
    print("otpCode ${_otpController.text}");
    if (_otpController.text.isNotEmpty){
      BlocProvider.of<CredentialCubit>(context)
          .submitSmsCode(smsCode: _otpController.text);
    }
  }



}
