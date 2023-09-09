import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:select_form_field/select_form_field.dart';

class Register extends StatefulWidget {


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  var formkey= GlobalKey<FormState>();
  late String vegname;
  late String quantity;
  late int price;
  late String offer;
  late int offprice;
  late String tops;
  late String categories;
  
  final List<Map<String,dynamic>> _topsale=[
    {
      'value':'Yes',
      'label':'Yes'
    },
    {
      'value':'No',
      'label':'No'
    }

  ];

   final List<Map<String,dynamic>> _cat=[
    {
      'value':'Bulbs',    
      'label':'Bulbs'
    },
    {
      'value':'Roots and Tubers',
      'label':'Roots and Tubers'
    },
     {
      'value':'Stem',
      'label':'Stem'
    },
     {
      'value':'Leaf',
      'label':'Leaf'
    },
     {
      'value':'Fruits',
      'label':'Fruits'
    },
     {
      'value':'Flower',
      'label':'Flower'
    },
     {
      'value':'Seeds',
      'label':'Seeds'
    },
     {
      'value':'Others',
      'label':'Others'
    },
    

  ];

  @override
  Widget build(BuildContext context) {

   bool isload=true;
    String path="";
     void upload(BuildContext ctx) async{
   
    FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpeg','jpg','png'],
    );
     File file;
    if (result!=null) {
       file=File(result.files.single.path!);
      path=file.path;
      print(file.path);


      final ref=await FirebaseStorage.instance.ref().child('veggies').child(vegname);
      final put=await ref.putFile(file);
      final url=await put.ref.getDownloadURL();
      final docid=await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').doc();
      final save=docid.set({
          'name':vegname,
          'quantity':quantity,         
          'price':price,
          'offer':offer,
          'img':url,
          'offprice':offprice,
          'tops':tops,
          'categories':categories,
          'setvalue':0,
          'total':0
      });
      final docusers=await FirebaseFirestore.instance.collection('users').get();
      docusers.docs.forEach((element) async{
        await FirebaseFirestore.instance.collection('veggies').doc(element.id).collection('veg').doc(docid.id).set({
          'name':vegname,
          'quantity':quantity,         
          'price':price,
          'offer':offer,
          'img':url,
          'offprice':offprice,
          'tops':tops,
          'categories':categories,
          'setvalue':0,
          'total':0
        });
      });
      
       final snack=SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green
        );
      ScaffoldMessenger.of(context).showSnackBar(snack);
      Navigator.pop(context);

      


    }
   
  }
  savefunc(BuildContext context){
   var isvalid= formkey.currentState!.validate();
   if (isvalid) {
     formkey.currentState!.save();
     if (path=="") {
      print('jsssssssssssssssssssss');
         final snack=SnackBar(
          content: Text('Upload a image for the veggie'),
          backgroundColor: Colors.red
        );
      ScaffoldMessenger.of(context).showSnackBar(snack);
     }
   }
  }
    
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
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
                 OutlinedButton(onPressed:()=>upload(context), child: Text('Upload',),style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.grey)
                  )),
                  SizedBox(height: 20,),
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
                 SelectFormField(
             //  style:const TextStyle(color: Colors.white),
              
              decoration: const InputDecoration(
                
                border: OutlineInputBorder(),
                label: Text('Top Sale'),
                labelStyle: TextStyle(
                 // color: Colors.white
                ),
                 enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide( color:  Color.fromARGB(255, 159, 159, 159)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 0, 0)),
              ),
              ),
              items: _topsale,
              
              onChanged: (val) => print(val),
              onSaved: (val) => tops=val!,
              validator: (value){
                if (value!.isEmpty) {
                   return 'Can\'t be empty';
                }
                return null;
              },
            ),
                SizedBox(height: 20,),
                SelectFormField(
             //  style:const TextStyle(color: Colors.white),
              
              decoration: const InputDecoration(
                
                border: OutlineInputBorder(),
                label: Text('Category'),
                labelStyle: TextStyle(
                 // color: Colors.white
                ),
                 enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide( color:  Color.fromARGB(255, 159, 159, 159)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 0, 0)),
              ),
              ),
              items: _cat,
              
              onChanged: (val) => print(val),
              onSaved: (val) => categories=val!,
              validator: (value){
                if (value!.isEmpty) {
                   return 'Can\'t be empty';
                }
                return null;
              },
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