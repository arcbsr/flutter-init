import 'package:flutter/material.dart';
import 'package:insurance_flutter/Screens/LoginScreen.dart';
import 'package:insurance_flutter/Screens/UI/CustomText.dart';
import 'package:sizer/sizer.dart';
import 'listitem/MyList.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<Widget> pages = [
    LoginPage(isShowAppBar: false),
    ListPage(),
    ListPage(),
    ListPage(),
  ];

  // CustomNavigationBar({required this.pages});
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
  
}
class _AppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.fromLTRB(0,20.0,0,0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // backgroundImage: NetworkImage('https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: NetworkImage('https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'),
            radius: 5.w,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 3),
                TextN(text: "Good Morning"),
                const SizedBox(height: 3),
                TitleB(text: "Hello! Guest")
              ],
            ),
          ),// Add some spacing between the two pieces of text
          Container(
            width: 40.w,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Button pressed!');
                  },
                ),
                // const SizedBox(width: 5),
                IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    print('Button pressed!');
                  },
                ),
                // SizedBox(width: 5),
                IconButton(
                  icon: Icon(Icons.notification_important),
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
    if(index == 3){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(isShowAppBar: true)),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: _AppBar(),
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 10.0,
      //   centerTitle: false,
      // ),
      body:  Column(
        children: [
          Container(height:15.h,child: _AppBar()),
          Expanded(child: widget.pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 10.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
