import 'package:coffee_store_app/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_tile.dart';
import '../model/coffee.dart';
import '../model/coffee_shop.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  int totalItems = 0;
  double totalPrice = 0;

  void calculateTotals(List<Coffee> cartItems){
    totalItems = 0;
    totalPrice = 0;
    for(var coffee in cartItems){
      totalItems += coffee.quantity;
      totalPrice += coffee.price * coffee.quantity;
    }
  }

  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) {
        calculateTotals(value.userCart);
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Your Cart",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              itemCount: value.userCart.length,
              itemBuilder: (context, index) {
                Coffee eachCoffee = value.userCart[index];
                return CartTile(
                  coffee: eachCoffee,
                  onPressed:() => value.removeItemFromCart(eachCoffee),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Total Quantity:", style: TextStyle(fontSize: 16)),
                    Spacer(),
                    Text('${totalItems}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text("Total Price:", style: TextStyle(fontSize: 16)),
                    Spacer(),
                    Text('\$${(totalPrice).toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          MyButton(text: "Pay Now", onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentPage(onPaymentSuccess: value.clearCart))
            );
          }),
        ],
      );
      }
    );
  }
}
