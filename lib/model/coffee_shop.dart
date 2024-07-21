import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_store_app/model/coffee.dart';
import 'package:coffee_store_app/services/product_service.dart';
import 'package:flutter/material.dart';

class CoffeeShop extends ChangeNotifier{
  final ProductService productService = ProductService();
  // static final List<Coffee> _shop = [
  //   Coffee(
  //     name: "Long Black",
  //     price: 4.10,
  //     imagePath: "lib/images/black.png",
  //   ),
  //   Coffee(
  //     name: "Latte",
  //     price: 4.00,
  //     imagePath: "lib/images/latte.png",
  //   ),
  //   Coffee(
  //     name: "Espresso",
  //     price: 4.10,
  //     imagePath: "lib/images/espresso.png",
  //   ),
  //   Coffee(
  //     name: "Iced Coffee",
  //     price: 4.10,
  //     imagePath: "lib/images/iced_coffee.png",
  //   ),
  // ];

  // final List<Coffee> _shop = [

  // ];

  // Future<void> addToFirebase()async {
  //   for(var coffee in _shop){
  //     await FirebaseFirestore.instance.collection('Products').add(coffee.toMap());
  //   }
  // }

  Stream<List<Coffee>> get coffeeShop => productService.getCoffeeStream();

  List<Coffee> _userCart = [];

  List<Coffee> get userCart => _userCart;

  void addItemToCart(Coffee coffee, int quantity){
    coffee.quantity = quantity;
    _userCart.add(coffee);
    notifyListeners();
  }

  void removeItemFromCart(Coffee coffee){
    _userCart.remove(coffee);
    notifyListeners();
  }

  void clearCart(){
    _userCart.clear();
    notifyListeners();
  }
}