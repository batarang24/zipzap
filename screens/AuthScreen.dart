import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late String  email;
  late String name;
  late String password;
 

  final formkey=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  bool islogin=true;
  bool forgot=false;

  void savefunc(BuildContext ctx) async{
    UserCredential authresult;
    var isvalid=formkey.currentState!.validate();
    if (isvalid) {
      formkey.currentState!.save();
     
     try {
        if (islogin) {
         authresult= await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else
      {
       
         authresult= await auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authresult.user!.uid).set({
          'email':email,
          'username':name,
          'password':password,
          'address':"",
          'img':'https://firebasestorage.googleapis.com/v0/b/zipzap-94261.appspot.com/o/users%2Fimg.png?alt=media&token=a752b480-ce3e-4694-884d-ee59509ca4cf',
        });
        var docs= await FirebaseFirestore.instance.collection('veggies').doc('WyaMqxrXxscNZen3FMhVQvxH1Pb2').collection('veg').get();
        docs.docs.forEach((element)async {
          
         await FirebaseFirestore.instance.collection('veggies').doc(authresult.user!.uid).collection('veg').doc(element.id).set({
             'name':element.get('name'),
          'quantity':element.get('quantity'),         
          'price':element.get('price'),
          'offer':element.get('offer'),
          'img':element.get('img'),
          'offprice':element.get('offprice'),
          'tops':element.get('tops'),
          'categories':element.get('categories'),
          'setvalue':0,
          'total':0
          });
        });
        
      }
     } on PlatformException catch (err) {
      
       var mssg="An error has been occurred";
      //print('fsfssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
       if (err.message!=null) {
         mssg=err.message!;
       }
      // print('==========================================================================');
       final snack=SnackBar(
          content: Text(mssg),
          backgroundColor: Colors.red
        );
      ScaffoldMessenger.of(context).showSnackBar(snack);
     }catch(err)
     {
      
      print('errrrrrrorrrrrr');
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
   
      return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: islogin? MediaQuery.of(context).size.height/3:MediaQuery.of(context).size.height/3),
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
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder()
                  ),
                   validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      email=value!;
                    },
                ),
                SizedBox(height: 20,),
                if(!islogin) Column(
                  children: [
                    TextFormField(
                
                  key: ValueKey('username'),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                        onSaved: (value){
                      name=value!;
                    }
                ),
                SizedBox(height: 20,)
                  ],
                ),
                TextFormField(
                   key:ValueKey('password'),
                  decoration: InputDecoration(
                    labelText: 'Password',
                     border: OutlineInputBorder()
                  ),
                   validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      password=value!;
                    }
                ),
                SizedBox(height: 10,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                  setState(() {
                    islogin= !islogin;
                  });
               }, child:Text( islogin?'New user?':'Already an user?')),
                islogin?Spacer():Container(),
                islogin?TextButton(onPressed: (){
                  Navigator.of(context).pushNamed('Forgot');
               }, child:Text( 'Forgot password?')):Container(),
                ],
               ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45)
                  ),
                  child: Text(islogin?'Login':'Signup'),
                  onPressed:()=>savefunc(context),
                )
                
              ],
              
            ),
           ),
          ),
            ]),
          ),
          )
          );
      
      
  
  }
}