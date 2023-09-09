import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zipzap/widgets/Vegtile.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  
  @override
  Widget build(BuildContext context) {
    var route=ModalRoute.of(context)!.settings.arguments as Map;
    var id=route['id'];
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
                    Text('Order Summary',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Spacer(),
                    GestureDetector(onTap: (){
                      showMenu(context: context, position:RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0), items: [
                        PopupMenuItem(child: Text('Cancel order',style: TextStyle(fontWeight: FontWeight.bold),),onTap: () {
                            FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(id).update(
                              {
                                'currentpos':'cancelled'
                              }
                            );
                        },)
                      ]);
                    }, child: Icon(Icons.more_vert,color: Colors.white,))

                  ],
                )
          ),
        ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20,right: 10,top: 10),
          //color: Colors.red,
          //height: 100,
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(id).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future:FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').doc(snapshot.data!.get('addr')).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),),
                          SizedBox(height: 10,),
                          Text(snapshot.data!.get('label'),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                           SizedBox(height: 5,),
                          Text(snapshot.data!.get('catchedadd')),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(snapshot.data!.get('givenadd')),
                              SizedBox(width: 5,),
                             Text(snapshot.data!.get('landmark')),
                            ],
                          ),
                           SizedBox(height: 5,),
                          Text(snapshot.data!.get('phone')),
                          Divider()

                        ],
                      );
                    }
                    else
                    {
                      return Container();
                    }
                  },
                );
              }
              else
              {
                return Container();
              }
            },
          ),
        ),
         
       Container(
        child:  Column(

          children: [
            Container(
              padding: EdgeInsets.only(left: 10,top: 8),
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(255, 121, 31, 109),
              child: Text('Summary',style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                
              ),),

            ),
            Container(
       
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(id).collection('vegetable').snapshots(),
            builder: (context, snapshot) {
            
            if (snapshot.hasData) {
               var a= snapshot.data!.docs;
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemCount: a.length,
                itemBuilder: (context, index) {

                  return FutureBuilder(
                    future: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(a[index].id).get(),
                    builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Vegtile(
                            snapshot.data!.get('img'),
                            snapshot.data!.get('name'),
                            snapshot.data!.get('quantity'),
                            snapshot.data!.get('price'),
                            snapshot.data!.get('offprice'),
                            a[index].get('setvalue'),
                            a[index].get('total'),
                          ),
                          Divider(),
                            ],
                          );
                        }
                        else
                        {
                          return Container();
                        }
                    },
                  );
                },
              ),
                );
            }
            else
            {
              return Container();
            }
            },
          ),
        ),
        Container(
         // height:100,
          margin: EdgeInsets.only(left: 20,right: 10),
          
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Order details',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
            
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('Order id',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Spacer(),
                  Text(id)
                ],
              ),
              SizedBox(height:20),
              FutureBuilder(                                        
                future: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(id).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(

                      children: [
                        Row(
                          children: [
                            Text('Total Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                            Spacer(),
                             Text('${snapshot.data!.get('total')}')
                          ],

                        ),
                        SizedBox(height:20),
                         Row(
                          children: [
                            Text('Order on',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                            Spacer(),
                             Text('${snapshot.data!.get('date')}'),
                             
                          ],

                        ),
                        SizedBox(height:20),
                        Row(
                          children: [
                            Text('Paying method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                            Spacer(),
                             Text('Cash on delivery')
                             
                          ],

                        )
                       
                    
                      ],
                    );
                  }
                  return Container();
                },
              ),


            ],
          ),
        )
          ],
        ),
       ),
       
       
          ],
        ),
      ),


    );
  }
}