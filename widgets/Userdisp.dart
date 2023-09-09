import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Userdisp extends StatelessWidget {
  const Userdisp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                margin: EdgeInsets.only(top: 15,bottom: 10),
               // height: 110,
                //color: Colors.red,
                
                child:StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder:(context, snapshot) {
                    if (snapshot.hasData) {
                     

                      return  Row(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        String path;
                        
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpeg','jpg','png'],
                        );
                        File file;
                        if (result!=null) {
                          file=File(result.files.single.path!);
                          path=file.path;
                          final ref=await FirebaseStorage.instance.ref().child('users').child(FirebaseAuth.instance.currentUser!.uid);
                          final put=await ref.putFile(file);
                          final url=await put.ref.getDownloadURL();
                          final save=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                            'img':url
                          });
                      }
                      },
                      child:Container(
                        margin: EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                      
    
                      radius: 35,
                      backgroundImage: NetworkImage(snapshot.data!.get('img')),
                      //child:snapshot.data!.get('img')!=""?Image.network(snapshot.data!.get('img'),fit:,):Container(),
                     
                    ),
                      )
                    ),
                    SizedBox(width: 20,),
                    Container(
                      alignment: Alignment.center,
                      //margin: EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.get('username'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                          SizedBox(height: 5,),
                          Text(snapshot.data!.get('email'))
                        ],
                      ),
                    )
                  ],
                );
                    }
                    return Container();
                  },
                ),
              );
  }
}