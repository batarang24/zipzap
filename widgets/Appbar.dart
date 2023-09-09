import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      color: Color.fromARGB(255, 121, 31, 109),
      child: SafeArea(
      
      child: Container(
        padding: EdgeInsets.all(10),
        //margin: EdgeInsets.only(top: 25,left: 20),
        child:Column(

          children: [
             Row(
              children: [
                Container(child: Text( 'ZipZap',style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),margin: EdgeInsets.only(left: 5),),
                Spacer(),
                Row(
                  
                  children: [
                     IconButton(onPressed: (){
                  Navigator.of(context).pushNamed('Cart');
                }, icon: Icon(Icons.shopping_bag,color: Colors.white,size: 30,)),
                     IconButton(onPressed: (){
                  Navigator.of(context).pushNamed('MyAccount');
                }, icon: Icon(Icons.menu,color: Colors.white,size: 30,))
                  ],
                )
              ],
             ),
             SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('Search');
              },
              child:  Container(
              //padding: EdgeInsets.symmetric(horizontal: 2),
              
              child: TextField(
                
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Search Veggies',
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  contentPadding: EdgeInsets.all(5),
                  fillColor: Colors.white,

                  filled: true,
                  suffixIcon: IconButton(icon: Icon(Icons.search,color: Colors.black,size: 25,),onPressed: (){},),
                  
                  isDense: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    
                  )
                ),
             ),
             ),
            ),
             SizedBox(height: 10,)
          ],
        )
      ),
    ),
    );
  }
}