import 'package:coffee_store_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await CoffeeShop.addToFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => CoffeeShop(), 
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}