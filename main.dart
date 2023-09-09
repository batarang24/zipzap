import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zipzap/providers/geoprovider.dart';
import 'package:zipzap/screens/Address.dart';
import 'package:zipzap/screens/Addressreg.dart';
import 'package:zipzap/screens/Cart.dart';
import 'package:zipzap/screens/Forgot.dart';
import 'package:zipzap/screens/MyOrders.dart';
import 'package:zipzap/screens/Orders.dart';
import 'package:zipzap/screens/Register.dart';
import 'package:zipzap/screens/Update.dart';
import 'package:zipzap/screens/ViewAdd.dart';
import './screens/Home.dart';
import './screens/MyAccount.dart';
import 'screens/AuthScreen.dart';
import 'screens/Searcher.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => Geobloc(),
       child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    primarySwatch:Colors.purple,
    
  ),
     home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return Home();
            }
            else
            {
              return AuthScreen();
            }
          },
        ),
     routes: {
      'MyAccount':(context)=>MyAccount(),
      'Search':(context) => Searcher(),
      'Cart':(context) => Cart(),
      'Register':(context)=>Register(),
      'Update':(context)=>UpdateScreen(),
      'Forgot':(context)=>Forgot(),
      'Address':(context) =>ViewAdd(),
      'Viewer':(context)=>Address(),
      'addreg':(context)=>Addressreg(),
      'Orders':(context) => Orders(),
      'MyOrders':(context)=>MyOrders(),
     },
    ),
    );
  }
}


