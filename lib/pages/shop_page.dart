import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/coffee_tile.dart';
import '../model/coffee.dart';
import '../model/coffee_shop.dart';
import '../pages/coffee_order_page.dart';

class ShopPage extends StatefulWidget {
  State<ShopPage> createState() => ShopStatePage();
}

class ShopStatePage extends State<ShopPage> {
  void goToCoffeePage(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CoffeeOrderPage(coffee: coffee)),
    );
  }

  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: Text(
              "How do you like your coffee?",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: StreamBuilder(
                stream: value.coffeeShop,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("Error");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading..");
                  }
                  return ListView(
                    children: snapshot.data!
                        .map<Widget>((coffee) => CoffeeTile(
                              coffee: coffee,
                              onPressed: () => goToCoffeePage(coffee),
                            ))
                        .toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
