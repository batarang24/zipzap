import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zipzap/providers/geoprovider.dart';
import '../models/Geoserv.dart';

import 'package:zipzap/services/searchextra.dart';
import 'package:zipzap/models/searchmodal.dart';

import '../models/Place.dart';

class  Selectprov with ChangeNotifier
{

  //final auto=Geobloc();
  final geoserv=Geoservice();
  final searchex=Searchextra();
  StreamController<Place> selectedLocation = StreamController<Place>();
  Place ? selectedLocationStatic;
  
   List<Searchmodal> ? autosearchers=[
    
   ];

 

   setSelectedLocation(String placeId) async {
    var sLocation = await searchex.searchplace(placeId);
    selectedLocation.add(sLocation!);
    selectedLocationStatic = sLocation;
    setmarker(sLocation.geometry.location.lat,sLocation.geometry.location.long);
    //auto.autosearchers=[];
   // searchResults = null;
    notifyListeners();
  }
  List<Marker> list=[];

  setmarker(double lat,double long){
    list.clear();
    list.add(
      Marker(
      markerId: MarkerId('1'),
      position: LatLng(lat,long)
    )
    );

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