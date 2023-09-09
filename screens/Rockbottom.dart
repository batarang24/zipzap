import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Rockbottom extends StatelessWidget {
  final double total;
  Rockbottom(this.total);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 400,
      width: double.infinity,
      color: Colors.red,
      child: Column(
        children: [
        Expanded(
          child:  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docs=snapshot.data!.docs;
              if (docs.length!=0) {
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width-100,
                      color: Colors.black,
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: 1, onChanged: (val){}),
                          ListTile(title: Text(docs[index]['label']),subtitle: Text(docs[index]['catchedadd']),)

                        ],
                      ),
                    ); 
                  },
                );
              }
              else
              {
                return Container();
              }
            }
            return Container();
            
          },
         ),
        )
          
        ],
      )

    );
  }
}