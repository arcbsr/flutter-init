import 'package:flutter/material.dart';
import 'package:insurance_flutter/Screens/LoginScreen.dart';
import 'package:insurance_flutter/Screens/UI/HomePage.dart';
import 'package:sizer/sizer.dart';
import 'app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<Widget> pages = [
    const HomePage(),
    // const CreateAccount(),
    // LoginForm(),
    // ListPage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  CustomNavigationBar({super.key});

  // CustomNavigationBar({required this.pages});
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // backgroundImage: NetworkImage('https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: const NetworkImage(
                // 'https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'
                'https://s3-media0.fl.yelpcdn.com/bphoto/aVf9ZKyRSzYdV5jNtuirFQ/348s.jpg'),
            radius: 5.w, //ScreenUtil().radius(25),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 3),
                Text(
                  "Good Morning",
                  style: AppTheme.subtitle,
                ),
                SizedBox(height: 3),
                Text(
                  "Hello! Guest",
                  style: AppTheme.title,
                )
              ],
            ),
          ), // Add some spacing between the two pieces of text
          SizedBox(
            //ScreenUtil().setWidth(100),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.qr_code),
                  onPressed: () {
                    print('Button pressed!');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notification_important),
                  onPressed: () {
                    print('Button pressed!');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  double _buttonSize = 24.0;
  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(isShowAppBar: false)),
      );
    }
    setState(() {
      _selectedIndex = index;
      _buttonSize = 30.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          //ScreenUtil().setHeight(80)
          Container(height: 16.h, child: _AppBar()),
          Expanded(child: widget.pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 8.h, //ScreenUtil().setHeight(60),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              label: "Booking",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: "Calendar",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox_outlined),
              label: "Inbox",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Menu",
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
