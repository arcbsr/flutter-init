import 'package:firebase_database/firebase_database.dart';
import 'package:insurance_flutter/Utils/Utils.dart';

import '../Utils/Constants.dart';
import 'databese/product/product_data.dart';

class OffersHome {
  final String imageLink;
  final String searchLink;
  String name = 'Default';
  String description = '', id = '';
  bool isActive = false;
  int discount = 0;
  List<ProductData> productata = [];

  OffersHome(this.imageLink, this.searchLink);
  Map<String, dynamic> toMap() {
    return {
      'imageLink': imageLink,
      'searchLink': searchLink,
      'isActive': isActive,
      'discount': discount,
      'name': name,
      'description': description,
    };
  }

  Future<String?> addOffer() async {
    try {
      final offerRef =
          FirebaseDatabase.instance.ref(ConstantsData.getOfferUrl());
      DatabaseReference newEntry = offerRef.push();
      newEntry.set(toMap());

      return newEntry.key;
    } catch (error) {
      return null;
    }
  }

  // offerprodid is parent id in offer product not product id
  static Future<bool> removerOffer(String offerID, String offerprodid) async {
    if (offerprodid.isEmpty) return false;
    try {
      final offerRef = FirebaseDatabase.instance
          .ref('${ConstantsData.getOfferUrl()}/$offerID/product/$offerprodid');
      // DatabaseReference newEntry = offerRef.push();
      offerRef.remove();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> acitveOrDeactive() async {
    try {
      final offerRef =
          FirebaseDatabase.instance.ref('${ConstantsData.getOfferUrl()}/$id');
      // DatabaseReference newEntry = offerRef.push();
      isActive = !isActive;
      offerRef.update({'isActive': isActive});

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<List<OffersHome>> getOffers() async {
    List<OffersHome> offers = [];
    DatabaseReference? ref =
        FirebaseDatabase.instance.ref(ConstantsData.getOfferUrl());

    DatabaseEvent event = await ref.once();

    final dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> productsData =
          dataSnapshot.value as Map<dynamic, dynamic>;
      productsData.forEach((key, value) {
        OffersHome offer = OffersHome(
            Utils.getValue(value, 'imageLink').isEmpty
                ? ConstantsData.IMAGE_THUMB_BIG
                : Utils.getValue(value, 'imageLink'),
            Utils.getValue(value, 'searchLink'));
        offer.discount = int.tryParse(Utils.getValue(value, 'discount')) ?? 0;
        offer.isActive = Utils.getValue(value, 'isActive') == 'true';
        offer.name = Utils.getValue(value, 'name');
        if (value['product'] != null) {
          Map<dynamic, dynamic> productoffData =
              value['product'] as Map<dynamic, dynamic>;
          productoffData.forEach((keye, valuee) async {
            if (Utils.getValue(valuee, 'pid').isNotEmpty &&
                Utils.getValue(valuee, 'subcatid').isNotEmpty) {
              ProductData? data = await ProductData.getProductById(
                  Utils.getValue(valuee, 'pid'),
                  Utils.getValue(valuee, 'subcatid'));
              data!.offerpdid = keye;
              data.imageurl = Utils.getValue(valuee, 'imageurl');
              offer.productata.add(data);
            }
          });
        }
        offer.id = key;
        offers.add(offer);
      });
    } else {}
    if (offers.isEmpty) {
      OffersHome offer = OffersHome(ConstantsData.IMAGE_THUMB_BIG, '');
      offers.add(offer);
    }
    return offers;
  }

  static Future<List<OffersHome>> getOfferss() async {
    return getOffers();
  }
}

class Offers {
  final String imageLink;
  final String searchLink;

  Offers(this.imageLink, this.searchLink);
}
