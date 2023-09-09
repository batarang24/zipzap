import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Searchtile extends StatelessWidget {
  final String name;
  final String img;
  final String quantity;
  final int price;
  final String offer;
  final int offprice;
  final int setvalue;
  final String id;

  Searchtile(this.name,this.img,this.quantity,this.price,this.offer,this.offprice,this.setvalue,this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 0,
      color: Colors.transparent,
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
            child:  Image.network(img,fit: BoxFit.contain)
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
              Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 10,),
              Text(quantity),
              SizedBox(height: 10,),
              Row(
          
                children: [
                  Text('\$${price}',style: TextStyle(decoration: TextDecoration.lineThrough),),
                   SizedBox(width: 10,),
                  Text('\$${offprice}',style: TextStyle(color: Colors.purple),)
                ],
              ),
              //Spacer(),
             
            ],
          ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right:10),
            child:  setvalue==0?
                       OutlinedButton(onPressed: ()async{
                         await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(id).update({
                            'total':(setvalue+1) * offprice,
                            'setvalue':setvalue+1,
                            
                          });


                          await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc().set(
                            {
                                'id':id,
                                'setvalue':setvalue
                            }
                          );
                       }, child: Text('ADD',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        
                      ),
                      )
                         :Container(
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
                               FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(id).update({
                                  'total':(setvalue-1 )* offprice,
                                  'setvalue':setvalue-1,
                                  
                              });
                            }, child:Container(child: Icon(Icons.minimize,size: 15,color: Colors.white,),alignment: Alignment(0,-0.4),)),
                            //SizedBox(width: 10,),
                            Text('${setvalue}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                             //SizedBox(width: 10,),
                            InkWell(
                              //padding: EdgeInsets.all(0),
                              onTap: (){
                               FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(id).update({
                              'total':(setvalue+1 )* offprice,
                              'setvalue':setvalue+1,
                              

                              });
                            }, child: Icon(Icons.add,size: 15,color: Colors.white,))
                          ],
                        ),
                      ),
          )
            
        ],
      ),
    );
  }
}