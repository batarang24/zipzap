import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final formkey=GlobalKey<FormState>();
  late String email;
  void savefunc(BuildContext context) async{
      final valid=formkey.currentState!.validate();
      if (valid) {
        formkey.currentState!.save();
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          final snack=SnackBar(
          content: Text('Reset password link has been sent'),
          backgroundColor: Color.fromARGB(255, 121, 31, 109),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        } catch (err) {
           final snack=SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        }
      }
  }

  @override
  Widget build(BuildContext context) {
   // String email;
    // TODO: implement build
    return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5),
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
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder()
                  ),
                 validator: (value){
                  if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                 }, 
                  onSaved: (value){
                      email=value!;
                    }
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45)
                  ),
                  child: Text('Send reset email link'),
                  onPressed:()=>savefunc(context),
                )
              ],
            ),
            )

          
          ),
            ]),
          ),
          )
          );
  }
}