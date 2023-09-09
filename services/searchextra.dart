import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zipzap/models/Place.dart';
import 'dart:convert' as convert;
import '../models/searchmodal.dart';

class Searchextra with ChangeNotifier
{
  Future<List<Searchmodal>> getautocomplete( String searcher) async{
    var url='https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searcher&types=establishment&location=10.7870%2C79.1378&radius=30000&&strictbounds=true&key=AIzaSyDrbBDX7sLU7LTyWdcFmbrAWBOtxzuNFCg';
    var response=await http.get(Uri.parse(url));
    var json=convert.jsonDecode(response.body);
    List<Map<String,dynamic>> all=[];
    List<dynamic> jsonresults=json['predictions'];
    jsonresults.forEach((element) {
     // print(element);
      print(element['description']);
      print(element);
      //print(element['placeid']);
     // print(Searchmodal.fromJson(element).description);
      all.add(element);
    });
    
    //print('----------------------------------------${jsonresults.length}------------------------');
    return  all.map((ele) => Searchmodal(ele['description'],ele['place_id'])).toList();
  //return all;
  
  }

  Future<Place ?>searchplace( String placeid) async{
    print('===-====================================================================${placeid}');
    var url='https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyDrbBDX7sLU7LTyWdcFmbrAWBOtxzuNFCg&placeid=$placeid';
    var response=await http.get(Uri.parse(url));
    var json=convert.jsonDecode(response.body);
   // List<Map<String,dynamic>> all=[];
  // print(json[''])
    var jsonresults=json['result'] as Map<String,dynamic>;
    //print(jsonresults.first['address_components'][0]['long_name']);
    return Place.fromJson(jsonresults);
    //print('----------------------------------------${jsonresults.length}------------------------');
     //jsonresults.map((ele){return Place.fromJson(ele);});
  //return all;
  
  }

 Future<Place ?> latlongtoplaceid(double lat, double long) async{
     var url='https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyDrbBDX7sLU7LTyWdcFmbrAWBOtxzuNFCg';
    var response=await http.get(Uri.parse(url));
    var json=convert.jsonDecode(response.body);
   // List<Map<String,dynamic>> all=[];
  // print(json[''])
    var jsonresults=json['results'][0] as Map<String,dynamic>;
    //print(jsonresults.first['address_components'][0]['long_name']);
    return searchplace(jsonresults['place_id']);

  }

}