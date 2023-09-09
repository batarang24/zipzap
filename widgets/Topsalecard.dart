import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  final String name;
  final String quantity;
  final int price;
  final String offer;
  final int offprice;
  final String img;
  final int setvalue;
  final String id;
  
  TopCard(
   
    this.name,
    this.quantity,
    this.price,
    this.offer,
    this.offprice,
    this.img,
    this.setvalue,
    this.id,
  );

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  @override
   //var setvalue=0;
   
  Widget build(BuildContext context) {
 
    return  Stack(
      children: [
     
           Card(
          
      child:
       Container(
          
          margin: EdgeInsets.only(left: 10,top: 12,right: 10),  
          child:
             
            Container(
            
              // color: Colors.black,
              child:    Column(
              
            children: [
              Container(
                height: 120,
                //color: Colors.amber,
                child: Image.network(widget.img,fit: BoxFit.cover,),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                //width: 200,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,style:TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      //margin: EdgeInsets.only(left: 0,right: 0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.quantity,style: TextStyle(color: Colors.purple),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text('\$${widget.offprice}',style:TextStyle(decoration: TextDecoration.lineThrough),),
                                  SizedBox(width: 10,),
                                  Text('\$${widget.price}',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          ),
                        ),
                        //Spacer(),
                       widget.setvalue==0?
                         OutlinedButton(onPressed: ()async{
                         await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(widget.id).update({
                            'total':(widget.setvalue+1) * widget.offprice,
                            'setvalue':widget.setvalue+1,
                            
                          });


                      
                       }, child: Text('ADD',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        
                      ),
                      )
                         :Container(
                        height: 35,
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
                               FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(widget.id).update({
                                   'total':(widget.setvalue-1) * widget.offprice,
                                  'setvalue':widget.setvalue-1,
                                  
                              });
                            }, child:Container(child: Icon(Icons.minimize,size: 15,color: Colors.white,),alignment: Alignment(0,-0.4),)),
                            //SizedBox(width: 10,),
                            Text('${widget.setvalue}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                             //SizedBox(width: 10,),
                            InkWell(
                              //padding: EdgeInsets.all(0),
                              onTap: (){
                               FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(widget.id).update({
                                'total':(widget.setvalue+1 )* widget.offprice,
                              'setvalue':widget.setvalue+1,
                               
                              });
                            }, child: Icon(Icons.add,size: 15,color: Colors.white,))
                          ],
                        ),
                      ),
                      ],
                    ),
                    )
                  ],
                ),
              )
            ],
          ),
       ),
                    
                    
      width: 220,
      //height: 200,
      
      decoration: BoxDecoration(
        
      borderRadius: BorderRadius.circular(5),
      color: Colors.white
      
),
),
    ),
    
          Container(
            margin: EdgeInsets.all(10),         
            padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(widget.offer,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
          ),
                    
        ],
     
    );
    
    
    
    
   ;
               
  }
}