// import 'package:firebase_push_notification/screens/widget/text_from_field.dart';
// import 'package:flutter/material.dart';
// class LoginScreen extends StatelessWidget {
//    LoginScreen({Key? key}) : super(key: key);
//    TextEditingController mobilenoController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomText(
//                 validator: ((uservalue) {
//                   if (uservalue.isEmpty) {
//                     return 'Please enter Mobile No';
//                   }
//                   return null;
//                 }),
//                 textinputaction: TextInputAction.next,
//                 textinputtype: TextInputType.number,
//                 obscure: false,
//                 controller: mobilenoController,
//                 hinttext: "MOBILE NO",
//                 labeltext: 'MOBILE NO',
//               ),
//               SizedBox(height: 30,),
//               ElevatedButton(onPressed: (){}, child: Text("Login"))
//             ],
//           ),
//         ),
//         ),
//       );
//
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_push_notification/screens/widget/text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  TextEditingController phoneController =
      TextEditingController(text: "+923028997122");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              validator: ((uservalue) {
                if (uservalue.isEmpty) {
                  return 'Please enter Mobile No';
                }
                return null;
              }),
              textinputaction: TextInputAction.next,
              textinputtype: TextInputType.number,
              obscure: false,
              controller: phoneController,
              hinttext: "MOBILE NO",
              labeltext: 'MOBILE NO',
            ),
            SizedBox(height: 30),
            Visibility(
              child: CustomText(
                validator: ((uservalue) {
                  if (uservalue.isEmpty) {
                    return 'Please enter Mobile No';
                  }
                  return null;
                }),
                textinputaction: TextInputAction.next,
                textinputtype: TextInputType.number,
                obscure: false,
                controller: otpController,
                hinttext: "OTP",
                labeltext: 'OTP',
              ),
              visible: otpVisibility,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
