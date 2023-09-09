import 'dart:async';


import './Location.dart';
class Geometry
{
  final Loc location;

  Geometry(this.location);

  Geometry.fromJson(Map<dynamic,dynamic> parsedJson)
      :location = Loc.fromJson(parsedJson['location']);
   
}