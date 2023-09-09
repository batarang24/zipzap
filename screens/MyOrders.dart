import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

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
                    Text('My Orders',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    

                  ],
                )
          ),
        ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').snapshots(),
            builder: (context, snapshot) {
              
              if (snapshot.hasData) {
                var docs=snapshot.data!.docs;
                return ListView.builder(
                  padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap:  () {
                    Navigator.of(context).pushNamed('Orders',arguments: {
                      'id':docs[index].id
                    });
                  },
                    child: Card(
      
      //elevation: 0,
     // color: Colors.transparent,
      child: Row(
     
        children: [
          
          Container(
           // padding: EdgeInsets.all(20),
           margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white 
            ),
            height: 80 ,
            width: 70,
            child:  Image.network('https://firebasestorage.googleapis.com/v0/b/zipzap-94261.appspot.com/o/veggies%2FCabbage?alt=media&token=5f66c86a-3f9c-442b-b0f0-4d06272778cb',fit: BoxFit.contain)
            ,//color: Colors.white,
          ),
          
          Container(
            margin: EdgeInsets.only(left: 20),
            //width: MediaQuery.of(context).size.width-1,
            //color: Colors.red,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Order #${index+1}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 10,),
              Text('Status: ${docs[index].get('currentpos')}' ,style: TextStyle(
                color: docs[index].get('currentpos')=='cancelled'?Colors.red:Colors.purple
              ),),
              Row(
          
                children: [
                 // Text('\$${price}',style: TextStyle(decoration: TextDecoration.lineThrough),),
                   SizedBox(width: 10,),
                 // Text('\$${offprice}',style: TextStyle(color: Colors.purple),)
                ],
              ),
              //Spacer(),
             
            ],
          ),
          ),
         
         
            
        ],
      ),
    ),
                  );
                },
              );
              }
              else
              {
                return Container();
              }
            },
          ),
        )
          ]
        ),
      )
    );
  }
}