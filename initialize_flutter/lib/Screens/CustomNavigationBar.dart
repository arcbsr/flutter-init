import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_flutter/Models/databese/user/UserModel.dart';
import 'package:insurance_flutter/Screens/LoginScreen.dart';
import 'package:insurance_flutter/Screens/UI/CartsItemList.dart';
import 'package:insurance_flutter/Screens/UI/HomePage.dart';
import 'package:insurance_flutter/Screens/UI/SavedItemsList.dart';
import 'package:insurance_flutter/Screens/UI/UserLoginPage.dart';
import 'package:insurance_flutter/providers/data_provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/Services/dataService.dart';
import 'UI/TextFieldDemo.dart';
import 'app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<Widget> pages = [
    const HomePage(),
    // const CreateAccount(),
    // LoginForm(),
    // ListPage(),
    const UserLoginPage(),
    const UserLoginPage(),
    const HomePage(),
    const HomePage(),
    const SavedItemsList(
      isCard: false,
    ),
    const CartItemsList(
      isCard: true,
    ),
  ];

  CustomNavigationBar({super.key});

  // CustomNavigationBar({required this.pages});
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        List<UserModel> usersmodel = ref.watch(dataProvider).userModel;
        Future<void> editUser(InputData? data) async {
          String url = '';
          try {
            url = await DataService().UploadImage(
                data!.filePickerResult, "images/users", usersmodel[0].userid);
          } on Exception catch (e) {
            // TODO
          }
          UserModel userModel = usersmodel[0];
          userModel.name = data!.name;
          userModel.imageurl = url.isNotEmpty ? url : data.imageLink;
          await userModel.saveUserIfNotExists();
          ref.read(dataProvider.notifier).refreshUser();
        }

        EditUser() {
          if (usersmodel.isEmpty || usersmodel[0].userid.isEmpty) {
            return;
          }
          final InputData inputData = InputData();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              inputData.name = usersmodel[0].name;
              inputData.imageLink = usersmodel[0].imageurl;
              return AlertDialog(
                title: const Text('Profile Edit'),
                content: TextFormFieldDemo.withData(
                  createCategory: editUser,
                  person: inputData,
                ),
              );
            },
          );
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(0, 25.0, 0, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // backgroundImage: NetworkImage('https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'),
                // (usersmodel.isNotEmpty && usersmodel[0].imageurl.isNotEmpty)
                //     ? usersmodel[0].imageurl
                //     : 'https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg'),
                radius: 5.w, //ScreenUtil().radius(25),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: EditUser,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (usersmodel.isNotEmpty)
                            ? '${usersmodel[0].phonenumber}\n${usersmodel[0].name}'
                            : "Hello! Guest",
                        style: AppTheme.title,
                      )
                    ],
                  ),
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
                        //print('Button pressed!');
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.notification_important),
                      onPressed: () {
                        //print('Button pressed!');
                      },
                    ),
                    Consumer(builder: (context, ref, child) {
                      return IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          // Consumer(
                          //   builder: (context, ref, child) {
                          ref.read(dataProvider.notifier).loadOffers();
                          //   },
                          // );
                          //print('Button pressed!');
                        },
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  int customIndex = 0;
  double _buttonSize = 24.0;
  void _onItemTapped(int index) {
    customIndex = index;
    if (index == 3) {
    } else if (index == 1) {
      if (UserModel.isUserLoggedIN()) {
        customIndex = 5;
      } else {}
    } else if (index == 2) {
      if (UserModel.isUserLoggedIN()) {
        customIndex = 6;
      } else {}
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
          SizedBox(height: 16.h, child: _AppBar()),
          Expanded(child: widget.pages[customIndex]),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 10.h, //ScreenUtil().setHeight(60),
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
              icon: Icon(Icons.favorite_sharp),
              label: "Saved",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: "My Cart",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "Orders",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Inbox",
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
