import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// freezed package for generation of boilperplate code
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insurance_flutter/Models/databese/Product.dart';

import '../Models/OffersHome.dart';
import 'Services/dataService.dart';
// Import freezed file (maybe not yet generated)
part 'product_provider.freezed.dart';

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState({
    @Default([]) List<Product> offers,
    @Default(false) bool isLoading,
  }) = _ProductState;

  const ProductState._();
}

// Creating state notifier provider
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>(
    (ref) => ProductNotifier());

// Creating Notifier
class ProductNotifier extends StateNotifier<ProductState> {
  // Notifier constructor - call functions on provider initialization
  ProductNotifier() : super(const ProductState()) {
    // init();
  }
  // loadOffers() async {
  //   final products = await DataService().fetchOffers();
  //   state = state.copyWith(offers: offers, isLoading: false);
  // }
  addProduct(Product product) async {
    state = state.copyWith(isLoading: true);
    bool isInsert = await DataService().addProduct(product);
    // try {
    //   final databaseReference = FirebaseDatabase.instance.reference();
    //   DatabaseReference newProductRef =
    //       databaseReference.child('products').push();
    //   await newProductRef.set({
    //     'name': product.name,
    //     'price': product.price,
    //     'description': product.description,
    //     'imageUrl': product.imageurl,
    //     'rating': product.rating,
    //     'ratingCount': product.ratingCount,
    //   });
    //   print('Product added successfully.');
    //   //return true;
    // } catch (error) {
    //   print('Failed to add product: $error');
    //   //return false;
    // }
    state = state.copyWith(isLoading: false);
  }

  void init() {
    // state = state.copyWith(isLoading: true);
  }
  //
  // addOffers() async {
  //   final offers = await DataService().fetchOffers();
  //   offers.add(OffersHome(
  //       "https://wallpapers.com/images/hd/cool-profisle-picture-ld8f4n1qemczkrig.jpg",
  //       "searchLink111"));
  //   state = state.copyWith(offers: offers, isLoading: false);
  // }
}
