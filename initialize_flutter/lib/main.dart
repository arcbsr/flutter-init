
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
// import 'package:device_preview/device_preview.dart';
import 'Screens/CustomNavigationBar.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const MyApp());

}
// void main() => runApp(
//   DevicePreview(
//     enabled: true,
//     builder: (context)=> const MyApp(),
//   ),
// );
final MaterialColor myWhite = MaterialColor(
  0xFFFFFFFF, // base color is white (0xFFFFFFFF)
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF), // this is the primary color
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
MaterialColor primaryColor = MaterialColor(
  0xFF7A6EFE,
  <int, Color>{
    50: Color(0xFF7A6EFE),
    100: Color(0xFF7A6EFE),
    200: Color(0xFF7A6EFE),
    300: Color(0xFF7A6EFE),
    400: Color(0xFF7A6EFE),
    500: Color(0xFF7A6EFE),
    600: Color(0xFF7A6EFE),
    700: Color(0xFF7A6EFE),
    800: Color(0xFF7A6EFE),
    900: Color(0xFF7A6EFE),
  },
);
final ThemeData myTheme = ThemeData(
  primarySwatch: primaryColor,
  backgroundColor: myWhite,// your primary color
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black, // set icon color here
    ),
  ),
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // set the status bar color to white
      statusBarIconBrightness: Brightness.dark, // set the text color to black
    ));
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      home: CustomNavigationBar(),
      builder: (context, child) => Sizer(
        builder: (context, orientation, deviceType) {
          return child!;
        },
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  Scaffold(
            // appBar: AppBar(
            //
            //   title: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       CircleAvatar(
            //         backgroundImage: AssetImage('assets/images/profile.jpg'),
            //         radius: 20.0,
            //       ),
            //       SizedBox(width: 8),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //         Text(
            //         'Sizer',style: TextStyle(fontSize: 15),
            //       ),
            //           Text(
            //             'Sizer',style: TextStyle(fontSize: 15),
            //           ),
            //         ],
            //       ),// Add some spacing between the two pieces of text
            //     ],
            //   ),
            //   automaticallyImplyLeading: false,
            //   titleSpacing: 10.0,
            //   centerTitle: false,
            // ),
            backgroundColor: Colors.yellow,
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
