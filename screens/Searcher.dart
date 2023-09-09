import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../widgets/Searchtile.dart';

class Searcher extends StatefulWidget {


  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  String val="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(
          children: [
            Container(
      height: 120,
      //margin: EdgeInsets.all(0),
      color: Color.fromARGB(255, 121, 31, 109),
      child: SafeArea(
      
      child: Container(
        padding: EdgeInsets.all(10),
        //margin: EdgeInsets.only(top: 25,left: 20),
        child:  Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                autofocus: true,
                onChanged: (value){
                  setState(() {
                    val=value;
                  });
                },
               // enabled: false,
                decoration: InputDecoration(
                  hintText: 'Search Veggies',
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,

                  filled: true,
                  suffixIcon: IconButton(icon: Icon(Icons.search,color: Colors.black,size: 25,),onPressed: (){},),
                  
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    
                  )
                ),
             ),
             ),
          
         
   
        
      ),
    ),
    ),
    Expanded(
        
         child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('veg').snapshots(),
          builder: (context, snapshot) {
            var len;
           
            
            if (snapshot.hasData) {
             len =snapshot.data!.docs.length==null?0:snapshot.data!.docs.length;
             final docs=snapshot.data!.docs;
            
            
            if (len==null) {
              return Container();
            }
            else
            {
               return ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: len,
                itemBuilder:(context, index) {
                  print(docs[index]['name']);
                  if (val.isEmpty) {
                    return Column(
                    children: [
                      Searchtile(docs[index]['name'],docs[index]['img'],docs[index]['quantity'],docs[index]['price'],docs[index]['offer'],docs[index]['offprice'],docs[index]['setvalue'],docs[index].id),
                      Divider()
                    ],
                  );
                  }
                  if (docs[index]['name'].toString().toLowerCase().startsWith(val.toLowerCase())) {
                     return Column(
                    children: [
                      Searchtile(docs[index]['name'],docs[index]['img'],docs[index]['quantity'],docs[index]['price'],docs[index]['offer'],docs[index]['offprice'],docs[index]['setvalue'],docs[index].id),
                      Divider()
                    ],
                  );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    
                  );
                },
              ); 
            }
          }
          return Container();
          },
         ),
      ),

    
          ],
        )
      )
    );
  }
}