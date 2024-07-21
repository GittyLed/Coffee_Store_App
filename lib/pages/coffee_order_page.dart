import 'package:coffee_store_app/components/my_button.dart';
import 'package:coffee_store_app/components/my_chip.dart';
import 'package:coffee_store_app/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import '../model/coffee.dart';
import '../model/coffee_shop.dart';

class CoffeeOrderPage extends StatefulWidget {
  final Coffee coffee;
  CoffeeOrderPage({required this.coffee});
  State<CoffeeOrderPage> createState() => CoffeeOrderPageState();
}

class CoffeeOrderPageState extends State<CoffeeOrderPage> {
  int quantity = 1;
  final List<bool> sizeSelection = [true, false, false];
  late ConfettiController confettiController;

  void initState(){
    super.initState();
    confettiController = ConfettiController(duration:Duration(seconds: 3),);
  }

  void increment() {
    setState(() {
      if (quantity < 10) {
        quantity++;
      }
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void selectSize(String size){
    setState(() {
      sizeSelection[0] = size == 'S';
      sizeSelection[1] = size == 'M';
      sizeSelection[2] = size == 'L';
    });
  }

  void addToCart(){
    if(quantity > 0){
      Provider.of<CoffeeShop>(context, listen: false).addItemToCart(widget.coffee, quantity);
      confettiController.play();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            "Successfully added to cart",
            style: TextStyle(color: Colors.white,),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: Text("Ok", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ).then((_) {
        confettiController.stop();
      });
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[900]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.coffee.imagePath,
                    height: 120,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        "Q U A N T I T Y",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: decrement,
                            color: Colors.grey,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 60,
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[800],
                                    fontSize: 30),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: increment,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Text("S I Z E", 
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => selectSize('S'),
                        child: MyChip(text: 'S', isSelected: sizeSelection[0],)
                      ),
                      SizedBox(width:4),
                      GestureDetector(
                        onTap: () => selectSize('M'),
                        child: MyChip(text: 'M', isSelected: sizeSelection[1],)
                      ),
                      SizedBox(width:4),
                      GestureDetector(
                        onTap: () => selectSize('L'),
                        child: MyChip(text: 'L', isSelected: sizeSelection[2],)
                      ),
                    ],
                  ),
                  SizedBox(height: 75),
                  MyButton(
                    text: 'Add To Cart',
                    onTap: addToCart,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
                Colors.pink,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
