import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zipzap/widgets/Userdisp.dart';
import 'package:zipzap/widgets/Usertile.dart';

import '../widgets/Appbar.dart';

class MyAccount extends StatelessWidget {
  alert(BuildContext context)
  {
   return showDialog(context:context , builder:(_){
    return AlertDialog(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                  title: Text('Do you really want to logout'),
                   actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, child: Text('Yes')),
                    
                    TextButton(onPressed: (){
                       Navigator.pop(context);
                    }, child: Text('No'))
                  ],
                );
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(
          children: [
                Container(
          height: 100,
          margin: EdgeInsets.all(0),
          color: Color.fromARGB(255, 121, 31, 109),
          child: SafeArea(
          
          child: Container(
            padding: EdgeInsets.all(10),
            //margin: EdgeInsets.only(top: 25,left: 20),
            child:
                Row(
                  children: [
                    Text('My Account',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                
                  ],
                )
          ),
        ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: [
              Userdisp(),
              Divider(),
              Usertile('Delivery',Icons.electric_bike,(){
                 Navigator.of(context).pushNamed('Search');
              }),
              Divider(),
              Usertile('My Orders',Icons.shopping_cart,(){
                Navigator.of(context).pushNamed('MyOrders');
              }),
              Divider(),
              Usertile('My Cart',Icons.shopping_bag,(){
                 Navigator.of(context).pushNamed('Cart');
              }),
              Divider(),
              Usertile('My Address',Icons.my_location,(){
                Navigator.of(context).pushNamed('Address');
              }),
              Divider(),
              Usertile('About App',Icons.person,(){}),
              Divider(),
              Usertile('Terms of Use',Icons.document_scanner,(){}),
              Divider(),
              Usertile('Log out',Icons.exit_to_app,()=> alert(context)),
              Divider(),
              
              FirebaseAuth.instance.currentUser!.uid=='WyaMqxrXxscNZen3FMhVQvxH1Pb2'?
              Usertile('Register', Icons.app_registration, () {Navigator.of(context).pushNamed('Register');}):Container(),
              Divider(),
              FirebaseAuth.instance.currentUser!.uid=='WyaMqxrXxscNZen3FMhVQvxH1Pb2'?
              Usertile('Update', Icons.update, () {Navigator.of(context).pushNamed('Update');}):Container()
              
            ],
          ),
        )
        ],
        ),
      ),
    ) ;
  }
}