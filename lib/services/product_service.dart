import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_store_app/model/coffee.dart';
import 'package:flutter/material.dart';

class ProductService extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  Future<void> addProduct(coffeeName, price, image) async {
    try {
      await _firestore
          .collection('Products')
          .doc(coffeeName)
          .set({'Name': coffeeName, 'Price': price, 'Image': image});
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Coffee>> getCoffeeStream() {
    return _firestore.collection("Products").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Coffee.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> deleteDocument(String coffeeName) async {
  try {
    await FirebaseFirestore.instance.collection('Products').doc(coffeeName).delete();
    print('Document deleted successfully');
  } catch (e) {
    print('Error deleting document: $e');
  }
}
}
