import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './Topsalecard.dart';

class Fixed extends StatefulWidget {
  final String title;
  Fixed(this.title);

  @override
  State<Fixed> createState() => _FixedState();
}

class _FixedState extends State<Fixed> {
  @override
  Widget build(BuildContext context) {
    return  Container(
                height: 290,
                
                //color: Color.fromARGB(255, 222, 220, 220),
                padding: EdgeInsets.symmetric(horizontal:5,vertical: 10),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(widget.title,style: TextStyle(
                      fontSize:18,
                      fontWeight:FontWeight.bold

                    ),),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').snapshots(),
                        builder:(context,snapshot){
                          if (snapshot.hasData) {
                            var cat=snapshot.data!.docs;
                            //print(cat.length);
                            return ListView(
                               scrollDirection: Axis.horizontal,
                                children: [
                                  ...cat.map((element) {
                                    if (element['categories']==widget.title) {
                                      print(element['name']);
                                      return  TopCard(
                                           element['name'],
                                           element['quantity'],
                                           element['price'],
                                           element['offer'],
                                           element['offprice'],
                                           element['img'],
                                           element['setvalue'],
                                           element.id,
                                        );
                                    }
                                    else
                                    {
                                      if (element['tops']=='Yes' && widget.title=='Top Sale') {
                                         return TopCard(
                                           element['name'],
                                           element['quantity'],
                                           element['price'],
                                           element['offer'],
                                           element['offprice'],
                                           element['img'],
                                           element['setvalue'],
                                           element.id,
                                        );
                                      }
                                      else
                                      {
                                        return Container();
                                      }
                                    }
                                  })
                                ],
                                  
                              
                            );
                          }
                          else
                          {
                            return Container();
                          }
                        }
                      )
                    )
                  ],
                ),
                
              );
  }
}