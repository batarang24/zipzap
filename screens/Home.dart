import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zipzap/widgets/Banners.dart';
import 'package:zipzap/widgets/Fixed.dart';
import 'package:zipzap/widgets/Topsalecard.dart';

import '../widgets/Appbar.dart';

 final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
 ];

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 

final List<Widget> imageSliders= imgList
    .map((item) =>Container(
          child: Container(
            margin: EdgeInsets.only( left: 18),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1050.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //endDrawer: Drawer(),
      body: 
       
       
        Container(
          child: Column(
          children: [
            Appbar(),
             
            Expanded(
              
              child: ListView(
                padding: EdgeInsets.only(top: 5),
                children: [
                  Container(
             
                    child: CarouselSlider(
                    
                      options: CarouselOptions(
                        aspectRatio: 2,
                      // enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                      ),
                      items: imageSliders,
                    )
                  ),
                    Column(
          children: [
         
            SizedBox(height: 10,),
             Fixed('Top Sale'),
            
            SizedBox(height: 10,),
            Fixed("Bulbs"),
             SizedBox(height: 5,),
            Banners(),
            SizedBox(height: 10,),
            Fixed('Roots and Tubers'),
             SizedBox(height: 10,),
            Fixed('Stem'),
              SizedBox(height: 5,),
            Banners(),
            SizedBox(height: 10,),
            Fixed('Leaf'),
             SizedBox(height: 10,),
            Fixed('Fruits'),
              SizedBox(height: 5,),
            Banners(),
            SizedBox(height: 10,),
            Fixed('Flower'),
            SizedBox(height: 10,),
            Fixed('Seeds'),
           
            

            
          ],
        ),
                ],
              ),
            )
          ],
        ),
        )
       
      );
      
    
  }
}