import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ViewAdd extends StatefulWidget {
  const ViewAdd({super.key});

  @override
  State<ViewAdd> createState() => _ViewAddState();
}

class _ViewAddState extends State<ViewAdd> {
      bool downward=false;
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
                    Text('Address',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),

                  ],

                ),

                
          ),
        ),
        ),

    
          Container(
          margin: EdgeInsets.all(20),
          child: OutlinedButton(onPressed: (){
            Navigator.of(context).pushNamed('Viewer');

          },
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle),
              
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('Choose an Location'),
              )
            ],
           ),
          
          style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        

        ),
        
        ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').snapshots(),
          builder:(context, snapshot) {
            if (snapshot.hasData) {
              var docs=snapshot.data!.docs;
             return Expanded(
            
              child:ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Container(
                   
                    child: Row(
                      children: [
                        Radio(value:docs[index].id, groupValue: docs[index]['prio'], onChanged: (val)async{
                          var doctor=await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').get();
                          doctor.docs.forEach((element)async {
                            await FirebaseFirestore.instance.collection('veggies').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').doc(element.id).update(
                            {
                              'prio':docs[index].id
                            }
                          );
                          });
                        }),
                        Container(
                           width: MediaQuery.of(context).size.width-100,
                           margin: EdgeInsets.only(left: 20),
                          child:  Card(
                      
                    child:  ListTile(
                      contentPadding: EdgeInsets.all(10),
                    title: Text(docs[index]['label'],style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(docs[index]['catchedadd']),
                    
                  
                  ),
                  ),
                        )
                      ],
                    ),
                  );
                },
              )
             );
            }
            else
            {
              return Container(); 
            }
            //
          },
        )
            ],
          ),
      
 
        
      ),
    
    );
     

  }
}