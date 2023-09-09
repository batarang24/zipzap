import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zipzap/screens/Rockbottom.dart';

import '../providers/geoprovider.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}


class _CartState extends State<Cart> {
  int total=0;



  @override
  Widget build(BuildContext context) {
    var geo=Provider.of<Geobloc>(context);
    
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
                    Text('My Cart',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),

                  ],
                )
          ),
        ),
        ),
        
        Expanded(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final docs=snapshot.data!.docs;
              return Column(
                children: [
                  Container(
                    child: ListView.builder(
                     shrinkWrap: true,
                padding: EdgeInsets.only(top: 10),
                itemCount: snapshot.data!.docs.length,
                
                itemBuilder: (context, index) {
                     if (docs[index]['setvalue']!=0) {
                    
                    return Container(
                      margin: EdgeInsets.only(right: 15),
                      child:Column(
                        children: [
                           ListTile(
                      
                      leading:Container(color: Colors.white, child:Image.network( docs[index]['img'],width: 60,height: 60,) ,),
                      title:Text(docs[index]['name']),
                      
                      subtitle: Wrap(
                        spacing: 12,
                        children: [
                          Text("${docs[index]['quantity']}"),
                          //Spacer(),
                          Text("₹${docs[index]['price']}",style: TextStyle(decoration: TextDecoration.lineThrough),),
                        ],
                      ),
                      trailing: 
                          
                        
                      Wrap(
                        alignment: WrapAlignment.spaceAround,
                        spacing: 30,
                          children: [
                             
                         Container(
                        height: 32,
                        width: 70,
                        padding: EdgeInsets.all(0),
                      
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // color: Color.fromARGB(255, 145, 57, 133)
                          color: Colors.purple
                        ),
                       
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            InkWell(
                              
                              onTap: (){
                               FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(docs[index].id).update({
                                   'total':(docs[index]['setvalue']-1)* docs[index]['offprice'],
                                  'setvalue':docs[index]['setvalue']-1,
                                 
                              });
                            }, child:Container(child: Icon(Icons.minimize,size: 15,color: Colors.white,),alignment: Alignment(0,-0.4),)),
                            //SizedBox(width: 10,),
                            Text('${docs[index]['setvalue']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                             //SizedBox(width: 10,),
                            InkWell(
                              //padding: EdgeInsets.all(0),
                              onTap: (){
                               FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(docs[index].id).update({
                              'total':(docs[index]['setvalue']+1)* docs[index]['offprice'],
                              'setvalue':docs[index]['setvalue']+1,
                               
                              });
                            }, child: Icon(Icons.add,size: 15,color: Colors.white,))
                          ],
                        ),
                      ),
                      Container( width: 35, margin: EdgeInsets.only(top:7),  child: Text('₹${docs[index]['offprice']}'),)
                          ],


                      )
                        
                      
                   

                      
                    ),
                    Divider()
                        ],
                      ),
                    );
                  }
                  else
                  {
                    return Container(
                    //  child: Text('Add veggies to cart'),
                    );
                  }
                },
              ),
                  ),
                  Spacer(),
                   Container(
                  height: 70,
                  padding: EdgeInsets.all(15),
                 // color: Colors.black,
                  child: ElevatedButton(
                    child: Text('Continue with ordering'),
                    onPressed: ()async{
                      double total=0;
                      final docss=await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').get();
                      docss.docs.forEach((element) {
                        total+=element.get('total');
                      });
                       final doctor=await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').get();
                       late var id='';
                      if (doctor.docs.length!=0) {
                       id=await doctor.docs.first.get('prio');
                      
                       
                      }
                      
                      if (total!=0) {
                       showModalBottomSheet(context: context, builder:(btx) {
                          
                          return Container(
                            //width: 100,
                            margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                            height: 300,
                            //color: Colors.red,
                            child: Column(
                              children: [
                                Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  
                                  children: [
                                   Container(
                                    width: MediaQuery.of(context).size.width/2-40,
                                    //color: Colors.green,
                                    child:  FittedBox(child: Text('Total: ${total}',style: TextStyle(fontSize: 20),),fit: BoxFit.contain,),
                                   ),
                                   ElevatedButton(
                                    
                                    onPressed: (){},
                                     child: Row(
                                    children: [
                                      Icon(Icons.add),
                                     // Spacer(),
                                     SizedBox(width: 10,),
                                      Text('Add more')
                                    ],
                                   ), style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 121, 31, 109),
                                   ),)
                                  ],
                                ),
                                const Spacer(),
                               // ElevatedButton(onPressed: (){}, child: Text('choose a location')),
                                ElevatedButton(onPressed: () async{
                                  var via= FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address');
                                  var order= await via.get();
                                  
                                  if (order.docs.length!=0) {
                                      
                                      var dockers=FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg');
                                      var yes=FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc();
                                      var domino=await dockers.get();
                                      var addid=await order.docs.first.get('prio');
                                      var placer;
                                      order.docs.forEach((element) {
                                        if (element.id==addid) {
                                          placer=element.get('placer');
                                        }
                                      });
                                      var i=0;
                                       await yes.set({
                                            'addr':addid,
                                            'currentpos':'ordered',
                                            'placer':placer,
                                            'total':total,
                                            'date':DateFormat.yMMMEd().format(DateTime.now())
                                          });
                                      domino.docs.forEach((element)async {
                                        if (element.get('setvalue')!=0) {
                                          i=i+1;
                                         
                                          await yes.collection('vegetable').doc(element.id).set(
                                            {
                                              'id':element.id,
                                              'setvalue':element.get('setvalue'),
                                              'total':element.get('total')
                                            }
                                          );
                                          await  dockers.doc(element.id).update(
                                          {
                                            'setvalue':0,
                                            'total':0,
                                          }
                                        );
                                       
                                        }
                                      });
                                      
                                      Navigator.pop(context);
                                       Navigator.of(context).pushNamed('Orders',arguments: {'id':yes.id});
                                      /*domino.docs.forEach((element) {
                                       
                                      });*/
                                  }
                                  else
                                  {

                                      Navigator.of(context).pushNamed('Address');
                                  }
                                }, child: Text('Place order'),style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 121, 31, 109),
                                minimumSize: Size.fromHeight(40)
                              ),)
                              ],
                            )
                          );
                       },); 
                      }
                      else
                      {
                        Navigator.of(context).pushNamed('Search');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 121, 31, 109),
                      minimumSize: Size.fromHeight(30)
                    ),
                  )
                )
                ],
              );
            }
            return Container(
              //child: Text('Add something to cart'),
            );
          },
        ),
      ),
     
          ]
        )
      ),
    
       
    
    );
    
  }
}


/*


      */