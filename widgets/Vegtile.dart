import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Vegtile extends StatelessWidget {
 final String img;
 final String name;
 final String quantity;
 final int price;
 final int offprice;
 final int setvalue;
 final int total;
  Vegtile(
    this.img,
    this.name,
    this.quantity,
    this.price,
    this.offprice,
    this.setvalue,
    this.total
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 0,
      color: Colors.transparent,
      child: Row(
     
        children: [
          
          Container(
           // padding: EdgeInsets.all(20),
           margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white 
            ),
            height: 80 ,
            width: 70,
            child:  Image.network(img,fit: BoxFit.contain)
            ,//color: Colors.white,
          ),
          
          Container(
            margin: EdgeInsets.only(left: 20),
            //width: MediaQuery.of(context).size.width-1,
            //color: Colors.red,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 10,),
              Text(quantity),
              SizedBox(height: 10,),
              Row(
          
                children: [
                  Text('\$${price}',style: TextStyle(decoration: TextDecoration.lineThrough),),
                   SizedBox(width: 10,),
                  Text('\$${offprice}',style: TextStyle(color: Colors.purple),)
                ],
              ),
              //Spacer(),
             
            ],
          ),
          ),
         Spacer(),
          Container(
            height: 80,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('x${setvalue}'),
                Text('\$${total}')
              ],
            ),
          )
         
            
        ],
      ),
    );
  }
}