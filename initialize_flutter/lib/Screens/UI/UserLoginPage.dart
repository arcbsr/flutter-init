import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_flutter/Models/databese/push_message.dart';
import 'package:insurance_flutter/Models/databese/user/UserModel.dart';
import 'package:insurance_flutter/Screens/app_theme.dart';
import 'package:insurance_flutter/providers/data_provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

import '../../providers/Services/dataService.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

enum LoginStatus { none, loading, sentotp, failed, loggedin, invalidphone }

final loginNotifierProvider =
    ChangeNotifierProvider((ref) => LoginNotifyProvide());

class LoginNotifyProvide extends ChangeNotifier {
  LoginStatus _currentStatus =
      UserModel.isUserLoggedIN() ? LoginStatus.loggedin : LoginStatus.none;
  LoginStatus get value => _currentStatus;
  // LoginNotifyProvide() {
  //   if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
  //     _currentStatus = LoginStatus.loggedin;
  //   } else {
  //     _currentStatus = LoginStatus.none;
  //   }
  // }
  void changeStatus(LoginStatus cStatus) {
    _currentStatus = cStatus;
    notifyListeners();
  }
}

class _UserLoginPageState extends State<UserLoginPage> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final phoneController = TextEditingController();
  String varificationID = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final currentStatus =
                ref.watch(loginNotifierProvider)._currentStatus;

            return (currentStatus == LoginStatus.loading)
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentStatus == LoginStatus.sentotp)
                        Column(
                          children: [
                            Text(
                              'OTP SEND TO ${phoneController.text}',
                              style: AppTheme.headline,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: 90.w,
                              child: OTPTextField(
                                length: 6,
                                fieldWidth: 50,
                                style: const TextStyle(fontSize: 17),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.box,
                                onCompleted: (pin) {
                                  completeSignin(pin, ref);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(loginNotifierProvider)
                                    .changeStatus(LoginStatus.none);
                                // Do something when the button is tapped
                              },
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.blue, width: 1.0))),
                                child: Text(
                                  'RESEND CODE',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      if (currentStatus == LoginStatus.none)
                        SizedBox(width: 70.w, child: phonneAuth(ref)),
                      if (currentStatus == LoginStatus.loggedin)
                        SizedBox(
                          height: 60,
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () async {
                                // UserModel.getUser();
                                await ref
                                    .read(dataProvider.notifier)
                                    .userSignOut();
                                ref
                                    .read(loginNotifierProvider)
                                    .changeStatus(LoginStatus.none);
                              },
                              child: const Text(
                                'Log Out',
                                style: AppTheme.body1,
                              )),
                        ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () async {
                              // await FirebaseMessaging.instance.sendMessage(
                              //     to: 'enWXlXV2R5S1_mOr780TpJ:APA91bGZvC1fXyE9CvIK3c5GgDM-4I8Gatx5dPyMTOf5B8iN2gxhY3PCRbEg4NaByAUKMNV6HsP2r9oSW2noxdhHor9l4JcCbVZ0tuafC-VUO1avqQpDsveQK_dTJPT5gfAXfbx08HWh',
                              //     messageId: 'test1',
                              //     messageType: 'test2',
                              //     data: <String, String>{
                              //       'click_action':
                              //           'FLUTTER_NOTIFICATION_CLICK',
                              // clear
                              //      'screen': 'single_notification_screen',
                              //     });
                              push_message message =
                                  push_message("title", 'body');
                              message.setUser(
                                  'enWXlXV2R5S1_mOr780TpJ:APA91bGZvC1fXyE9CvIK3c5GgDM-4I8Gatx5dPyMTOf5B8iN2gxhY3PCRbEg4NaByAUKMNV6HsP2r9oSW2noxdhHor9l4JcCbVZ0tuafC-VUO1avqQpDsveQK_dTJPT5gfAXfbx08HWh');
                              await DataService().sendNotification(message);
                            },
                            child: const Text(
                              'Send Notification',
                              style: AppTheme.body1,
                            )),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  completeSignin(String code, WidgetRef ref) async {
    ref.read(loginNotifierProvider).changeStatus(LoginStatus.loading);
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = code;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: varificationID, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    UserModel user = UserModel();
    //don't add userid....
    user.phonenumber = phoneController.text;
    bool isInserted = await user.saveUserIfNotExists();
    if (isInserted) {
      await ref.read(dataProvider.notifier).refreshUser();
    }
    ref.read(loginNotifierProvider).changeStatus(LoginStatus.loggedin);
  }

  Widget phonneAuth(WidgetRef ref) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            // LengthLimitingTextInputFormatter(10),
            // _PhoneNumberFormatter(),
          ],
          controller: phoneController,
          decoration: const InputDecoration(
            hintText: '11 digit...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () async {
            if (phoneController.text.length < 11) {
              return;
            }
            ref.read(loginNotifierProvider).changeStatus(LoginStatus.loading);
            FirebaseAuth auth = FirebaseAuth.instance;

            await auth.verifyPhoneNumber(
              phoneNumber: '+${phoneController.text}',
              timeout: const Duration(seconds: 60),
              verificationCompleted: (PhoneAuthCredential credential) {},
              codeSent: (String verificationId, int? resendToken) async {
                varificationID = verificationId;
                ref
                    .read(loginNotifierProvider)
                    .changeStatus(LoginStatus.sentotp);
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
              verificationFailed: (FirebaseAuthException e) {
                ref.read(loginNotifierProvider).changeStatus(LoginStatus.none);
                if (e.code == 'invalid-phone-number') {}

                // Handle other errors
              },
            );
          },
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text('SENT OTP'),
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.send),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
  // ElevatedButton googlelogout() {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       try {
  //         await FirebaseAuth.instance.signOut();
  //         User? user = FirebaseAuth.instance.currentUser;
  //         if (user != null) {
  //           String uid = user.uid; // User ID
  //           String email = user.email!; // User email (if available)
  //           String displayName =
  //               user.displayName ?? ''; // User display name (if available)
  //           String photoURL =
  //               user.photoURL ?? ''; // User photo URL (if available)
  //         }
  //       } catch (e) {}
  //     },
  //     child: Text('Sign in with Google'),
  //   );
  // }

  // ElevatedButton GoogleLogin() {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       try {
  //         // FirebaseAuth.instance.signOut();
  //         // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //         //   if (user != null) {
  //         //     String uid = user.uid; // User ID
  //         //     String email = user.email!; // User email (if available)
  //         //     String displayName = user.displayName ??
  //         //         ''; // User display name (if available)
  //         //     String photoURL = user.photoURL ?? '';
  //         //   } else {
  //         //     // User is signed in
  //         //   }
  //         // });
  //         User? user = FirebaseAuth.instance.currentUser;

  //         if (user != null) {
  //           String uid = user.uid; // User ID
  //           String email = user.email!; // User email (if available)
  //           String displayName =
  //               user.displayName ?? ''; // User display name (if available)
  //           String photoURL =
  //               user.photoURL ?? ''; // User photo URL (if available)
  //         }
  //         final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //         final GoogleSignInAuthentication googleAuth =
  //             await googleUser!.authentication;
  //         final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken,
  //           idToken: googleAuth.idToken,
  //         );
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //       } catch (e) {
  //         print(e);
  //       }
  //     },
  //     child: Text('Sign in with Google'),
  //   );
  // }

