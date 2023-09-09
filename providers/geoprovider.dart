import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/Geoserv.dart';

import 'package:zipzap/services/searchextra.dart';
import 'package:zipzap/models/searchmodal.dart';

import '../models/Place.dart';

class Geobloc with ChangeNotifier
{
  int total=0;
  bool maps=true;
   double ? lat;
  double ? long;
  final geoserv=Geoservice();
  final searchex=Searchextra();
  StreamController<Place> selectedLocation = StreamController<Place>();
  Place ? selectedLocationStatic;
  Place ? kalistro;
   Position ? currentloc;
   double ? amount;
   List<Searchmodal> ? autosearchers=[
    
   ];

  Geobloc()
  {
   //// print('ssssssssssssssssssssssss');
    setcurrentlocation();
  }

  setcurrentlocation() async{
   // print('sddddsfsfsoooooooooooo');
    currentloc=await geoserv.getcurrentloc();
    
    notifyListeners();
  }

  autoplaces(String searcher) async{
    autosearchers= await searchex.getautocomplete(searcher) ;
    autosearchers!.forEach((element) {
      print(element.description);
    });
    notifyListeners();
  }

  latlonger(double lat,double long) async{
      lat=lat;
      long=long;
      var sLocation= await searchex.latlongtoplaceid(lat,long) ;
     
       selectedLocationStatic = sLocation;
  
    notifyListeners();
  }
   setSelectedLocation(String placeId) async {
    var sLocation = await searchex.searchplace(placeId);
    selectedLocation.add(sLocation!);
    selectedLocationStatic = sLocation;
    setmarker(sLocation.geometry.location.lat,sLocation.geometry.location.long);
    autosearchers=[];
   // searchResults = null;
    notifyListeners();
  }

   /*touchlocation(double lat ,double long) async {
    var sLocation = await searchex.toucher(lat,long);
    selectedLocation.add(sLocation!);
    selectedLocationStatic = sLocation;
    setmarker(sLocation.geometry.location.lat,sLocation.geometry.location.long);
    autosearchers=[];
   // searchResults = null;
    notifyListeners();
  }*/


  List<Marker> list=[];

  setmarker(double lat,double long) async{
    list.clear();
    list.add(
      Marker(
      markerId: MarkerId('1'),
      position: LatLng(lat,long)
    )
    );
   //kalistro=await touchlocation(lat, long);
     print('==================================KALISTRO=========================================================');
   //print(kalistro!.name);
 
   //maps=false;
   notifyListeners();
  }

  mapchanger()
  {
    maps=false;
    notifyListeners();
  }
  updatetotal(int tot){
    total=tot;
    notifyListeners();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    print('jeeeeeeeeeeeeeeeeeeeeeeeeeeee**********************');
    selectedLocation.close();
  
    //selectedLocation = StreamController<Place>();
    super.dispose();
  }
}