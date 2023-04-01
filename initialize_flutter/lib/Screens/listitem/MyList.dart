import 'package:flutter/material.dart';
import 'package:insurance_flutter/Screens/LoginScreen.dart';
import 'package:insurance_flutter/Screens/UI/CustomText.dart';

import 'package:sizer/sizer.dart';
class Item {
  String name;
  String description;
  String image;

  Item({required this.name, required this.description, required this.image});
}

List<Item> _items = [
  Item(
    name: 'Item 1',
    description: 'Description for Item 1',
    image: 'assets/item1.png',
  ),
  Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),Item(
    name: 'Item 2',
    description: 'Description for Item 2',
    image: 'assets/item2.png',
  ),
  // Add more items as needed
];
class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
        Item item = _items[index];
        return ListTile(
          leading: Image.network("https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg"),
          title: TitleB(text: item.name),
          subtitle: TextNM(text: item.description, isSingleLine: false),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(isShowAppBar: true)),
            );
          },
        );
        },
      ),
    );
  }
}