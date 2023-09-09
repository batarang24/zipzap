
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:zipzap/models/distance.dart';

class Addressreg extends StatefulWidget {
  const Addressreg({super.key});

  @override
  State<Addressreg> createState() => _AddressregState();
}

class _AddressregState extends State<Addressreg> {
  final formkey=GlobalKey<FormState>();
  late String landmark;
  late String doorno;
  late String phone;
  late String label;
  savefunc(BuildContext context,double lat,double long,String loc) async{
    var validate=formkey.currentState!.validate();
    if (validate) {
      formkey.currentState!.save();
      Distance d=Distance();
      late SnackBar snack;
      double dist1=d.calculateDistance(lat, long, 10.7874,79.1376 );
      double dist2=d.calculateDistance(lat, long, 10.750073,79.112395 );
      double mins=min(dist1, dist2);
     
    
      
      if (mins<=25) {
        if (dist1==mins) {
          var document= FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').doc();
           var dancedoc= await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').get();
           var prio=document.id;
          if (dancedoc.docs.length!=0) {
             prio= dancedoc.docs.first.get('prio');
          }
       
        await document.set({
            'catchedadd':loc,
            'givenadd':doorno,
            'landmark':landmark,
            'lat':lat,
            'long':long,
            'phone':phone,
            'placer':'old',
            'prio':prio,
            'label':label,
          });

          Navigator.pop(context);
          Navigator.pop(context);
          snack=new SnackBar(content: Text('old'),backgroundColor: Colors.green,);

        }
        else
        {
          if (dist2==mins) {
            var document=FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').doc();
             var dancedoc= await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').get();
           var prio=document.id;
          if (dancedoc.docs.length!=0) {
             prio= dancedoc.docs.first.get('prio');
          }
            await document.set({
            'catchedadd':loc,
            'givenadd':doorno,
            'landmark':landmark,
            'lat':lat,
            'long':long,
            'phone':phone,
            'placer':'new',
            'prio':prio,
            'label':label
          });


            Navigator.pop(context);
            Navigator.pop(context);
            snack=new SnackBar(content: Text('new'),backgroundColor: Colors.green,);



          }
        }
      }
      else
      { 
        Navigator.pop(context);
        Navigator.pop(context);
        snack=new SnackBar(content: Text('nooo'),backgroundColor: Colors.red,);
        
      }
        ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }
  @override
  Widget build(BuildContext context) {
   final args= ModalRoute.of(context)!.settings.arguments as Map;
  String name=args['loc'];
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
                    Text('Address',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),

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
                 enabled: false,
                 
                  decoration: InputDecoration(
                    labelText:name,
                    border: OutlineInputBorder()
                  ),
                  
        
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    TextFormField(
                
                 
                  decoration: InputDecoration(
                    labelText: 'Door No/Street name',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                        if (value!.isEmpty ) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                        onSaved: (value){
                         doorno=value!;
                    }
                ),
                SizedBox(height: 20,)
                  ],
                ),
                 TextFormField(
                    
                  decoration: InputDecoration(
                    labelText: 'Label for the address',
                     border: OutlineInputBorder()
                  ),
                 
                   validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Can\'t be empty';
                      }
                      return null;
                    },
                    onSaved: (value){
                      label=value!;
                    }
                ),
                SizedBox(height: 20,),
                TextFormField(
                    
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                     border: OutlineInputBorder()
                  ),
                 
                   validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Can\'t be empty';
                      }
                      return null;
                    },
                    onSaved: (value){
                      landmark=value!;
                    }
                ),
                SizedBox(height: 20,),

                TextFormField(
                   enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Thanjavur',
                     border: OutlineInputBorder()
                  ),
                  //keyboardType:TextInputType.number,
                 
                ),
                SizedBox(height: 20,),
                TextFormField(
                   enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Tamil Nadu',
                     border: OutlineInputBorder()
                  ),
                  keyboardType:TextInputType.number,
                 
                ),
                 SizedBox(height: 20,),
                 TextFormField(
                   //enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                     border: OutlineInputBorder()
                  ),
                  keyboardType:TextInputType.number,
                  validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Can\'t be empty';
                      }
                      return null;
                    },
                    onSaved: (value){
                      phone=value!;
                    }
                ),
                 SizedBox(height: 20,),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45)
                  ),
                  child: Text('Submit'),
                  onPressed:()=>savefunc(context,args['lat'],args['long'],args['loc'])
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