import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'Screens/CustomNavigationBar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Screens/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  // return runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   // run web-specific code
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: 'AIzaSyALzp1XP5T41OzUw3S1hzHeNv1rl72z-e0"',
  //           appId: '1:720406346710:web:284597d0d5174b5a110277',
  //           messagingSenderId: '720406346710',
  //           databaseURL:
  //               'https://flutterdbapp-5f476-default-rtdb.firebaseio.com',
  //           projectId: 'flutterdbapp-5f476'));
  // } else {
  //   // run mobile-specific code
  //   await Firebase.initializeApp();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: const NvHomePage(
        title: 'Home',
      ),
    );
  }
}

class NvHomePage extends StatefulWidget {
  const NvHomePage({super.key, required this.title});
  final String title;

  @override
  State<NvHomePage> createState() => _NvHomePageState();
}

class _NvHomePageState extends State<NvHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   String token = value!;
    // });

    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text("Notification"),
    //           content: Text(event.notification!.body!),
    //           actions: [
    //             TextButton(
    //               child: Text("Ok"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //             )
    //           ],
    //         );
    //       });
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, designSize: const Size(360, 690));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Scaffold(
        // backgroundColor: Colors.yellow,
        body: CustomNavigationBar(),
      ),
      builder: (context, child) => Sizer(
        builder: (context, orientation, deviceType) {
          return child!;
        },
      ),
    );
  }
}
