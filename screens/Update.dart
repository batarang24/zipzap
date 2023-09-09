import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  
  var formkey=GlobalKey<FormState>();
  late String vegname;
  late String quantity;
  late int price;
  late String offer;
  late int offprice;

  
  

  void savefunc(BuildContext context) async{
    var isvalid= formkey.currentState!.validate();
   if (isvalid) {
     formkey.currentState!.save();
     int kilo=0;
      var docs=await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').get();
      var name=docs.docs.forEach((element) {
        
          if (element['name']==vegname)  {
            kilo=1;
            var update=  FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc(element.id).update(
              {
                "quantity":quantity,
                "price":price,
                "offer":offer,
                "offprice":offprice
              }
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Text('Success',textAlign: TextAlign.center,) ,
                backgroundColor: Color.fromARGB(255, 121, 31, 109),
              )
            );

             
          }

          
      });
      if (kilo==0) {
       
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Text('Write the correct veggie name') ,
                backgroundColor: Colors.red,
              )
            );
          
      }
        /* final snack=SnackBar(
          content: Text('Upload a image for the veggie'),
          backgroundColor: Colors.red
        );
      ScaffoldMessenger.of(context).showSnackBar(snack);
     }*/
   }
  }
  @override
   Widget build(BuildContext context) {
          
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                    Text('Register',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),

                  ],

                ),
                
          ),
        ),
        ), 
        Expanded(
          child:   ListView(
            padding: EdgeInsets.only(top: 5),
            children: [
              Container(
             // margin: EdgeInsets.only(top: islogin? MediaQuery.of(context).size.height/3:MediaQuery.of(context).size.height/4),
              child:Column(children: [
             // Container(),
              //Spacer(),
               Padding(
            padding: EdgeInsets.all(15),
           child: Form(
            key: formkey,
            child: Column(
              children: [
                 
                TextFormField(
                  key: ValueKey('Veggie'),
                  decoration: InputDecoration(
                    labelText: 'Veggie Name',
                    border: OutlineInputBorder()
                  ),
                   validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a veggie name';
                      }
                      return null;
                    },
                    onSaved: (value){
                      //email=value!;
                      vegname=value!;
                    },
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    TextFormField(
                
                  key: ValueKey('Quantity'),
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                        if (value!.isEmpty ) {
                          return 'Please enter quantity value';
                        }
                        return null;
                      },
                        onSaved: (value){
                         quantity=value!;
                    }
                ),
                SizedBox(height: 20,)
                  ],
                ),
                TextFormField(
                   key:ValueKey('orgPrice'),
                  decoration: InputDecoration(
                    labelText: 'Original Price',
                     border: OutlineInputBorder()
                  ),
                  keyboardType:TextInputType.number,
                   validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Please enter price value.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      price=int.parse(value!);
                    }
                ),
                SizedBox(height: 20,),
                TextFormField(
                   key:ValueKey('offer'),
                  decoration: InputDecoration(
                    labelText: 'Offer',
                     border: OutlineInputBorder()
                  ),
                  //keyboardType:TextInputType.number,
                   validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Please enter offer value value.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      offer=value!;
                    }
                ),
                SizedBox(height: 20,),
                TextFormField(
                   key:ValueKey('offPrice'),
                  decoration: InputDecoration(
                    labelText: 'Offer Price',
                     border: OutlineInputBorder()
                  ),
                  keyboardType:TextInputType.number,
                   validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Please enter off price';
                      }
                      return null;
                    },
                    onSaved: (value){
                       offprice=int.parse(value!);
                    }
                ),
                 SizedBox(height: 20,),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45)
                  ),
                  child: Text('Submit'),
                  onPressed:()=>savefunc(context)
                )
                
              ],
              
            ),
           ),
          ),
            ]),
          ),
            ],
          ) ,
        )
          ],
        ),
      ),
    );
  }
 
  
  
  

}