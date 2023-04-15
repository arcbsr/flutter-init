import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_flutter/Models/OffersHome.dart';
import 'package:insurance_flutter/Screens/UI/HomeCategory.dart';
import 'package:insurance_flutter/Utils/ScreenUtils.dart';
import 'package:insurance_flutter/providers/data_provider.dart';
import 'package:sizer/sizer.dart';

import '../../Models/databese/Product.dart';
import '../../Models/databese/product/product_insertui.dart';
import '../../providers/product_provider.dart';
import '../app_theme.dart';
import '../listitem/CardItems.dart';
import 'HomeOffers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class CounterIndicator extends ChangeNotifier {
  int _currentPage = 0;
  int get value => _currentPage;

  void changePage(int cPage) {
    _currentPage = cPage;
    notifyListeners();
  }
}

class _HomePageState extends State<HomePage> {
  bool isInsertAction = false;
  final List<String> items = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Apple',
    'Banana',
    'Orange',
    'Mango'
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // void _changeText() {
  //   setState(() {
  //     _searchText = _searchController.text;
  //   });
  // }

  void fetchData() async {
    Future.delayed(const Duration(seconds: 10), () {
      List<OffersHome> fetchedItems = [];
      fetchedItems.add(OffersHome(
          "https://wallpapers.com/images/hd/cool-profisle-picture-ld8f4n1qemczkrig.jpg",
          "searchLink111"));
      fetchedItems.add(OffersHome(
          "https://wallpapers.com/images/hd/cool-profisle-picture-ld8f4n1qemczkrig.jpg",
          "searchLink222"));
      fetchedItems.add(OffersHome(
          "https://wallpapers.com/images/hd/cool-profisle-picture-ld8f4n1qemczkrig.jpg",
          "searchLink333"));
      fetchedItems.add(OffersHome(
          "https://wallpapers.com/images/hd/cool-profisle-picture-ld8f4n1qemczkrig.jpg",
          "searchLink444"));
      // setState(() {
      //   offerItems = fetchedItems;
      //   counteOfferItems = offerItems.length;
      // });
    });
    // Fetch data from API

    // Update the state and rebuild the widget
  }

  void insertData(WidgetRef watch) async {
    // watch.read(productProvider.notifier).init();
    Product product = Product(
      id: 'asdasdsa',
      description: 'I am description',
      imageurl:
          "https://s3-media0.fl.yelpcdn.com/bphoto/aVf9ZKyRSzYdV5jNtuirFQ/348s.jpg",
      name: 'Home Clean',
      price: 25,
      userId: 'GfKtzTg09BTo2qdJ76CgvQfqqFD2',
    );
    await watch.read(productProvider.notifier).addProduct(product);
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });

    //fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

//Container(height: 16.h,child: Text("data")),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          List<OffersHome> offerItems = watch.watch(dataProvider).offers;
          List<Product> products = watch.watch(dataProvider).products;
          bool isLoading = watch.watch(dataProvider).isLoading;
          return isLoading
              ? const Center(
            child: CupertinoActivityIndicator(),
          )
              : OfferSection(watch, isLoading, offerItems, products);
        }),
      ),
    );
  }

  Widget OfferSection(WidgetRef watch, bool isLoading,
      final List<OffersHome> offerItemss, List<Product> products) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (String value) {
                  // Perform action when 'done' key is pressed
                  // _changeText();
                },
              ),
            ),
          ],
        ),

        // isLoading ? CircularProgressIndicator() : Text("Done..."),

        // ElevatedButton(
        //   onPressed: () async {
        //     // await watch.read(dataProvider.notifier).addReview();
        //     // await watch.read(dataProvider.notifier).addProduct(product);
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => InsertForm(
        //             subcatid: '',
        //           ),
        //         ));
        //   },
        //   child: const Text("Insert"),
        // ),
        // ElevatedButton(
        //   onPressed: () async {
        //     Product product = Product(
        //       id: 'asdasdsa',
        //       description: 'I am description',
        //       imageurl:
        //           "https://s3-media0.fl.yelpcdn.com/bphoto/aVf9ZKyRSzYdV5jNtuirFQ/348s.jpg",
        //       name: 'Home Clean',
        //       price: 25.0,
        //       userId: 'GfKtzTg09BTo2qdJ76CgvQfqqFD2',
        //     );
        //     await watch.read(dataProvider.notifier).addProduct(product);
        //   },
        //   child: const Text("Add Product"),
        // ),
        const SizedBox(height: 10.0),
        SizedBox(
            width: 90.w,
            height: 20.h,
            child: HomeOffers(offerItems: offerItemss)),
        const SizedBox(height: 15.0),
        SizedBox(width: 90.w, height: 35.h, child: const HomeCategory()),

        SingleChildScrollView(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: products.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ScreentUtils.isLargeScreen(context, 900) ? 3 : 1,
              // (MediaQuery.of(context).size.width ~/ 200).clamp(1, 3),
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio:
                  ScreentUtils.isLargeScreen(context, 900) ? 3 : 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 100,
                child: CardItems(
                  serviceItem: products[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  CustomCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
