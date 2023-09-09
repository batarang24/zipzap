
import './Geometry.dart';
class Place
{
  final Geometry geometry;
  final String name;
  final String vicinity;
  
  Place(this.geometry,this.name,this.vicinity);
  
  factory Place.fromJson(Map<String,dynamic> json)
  {
     return Place(
        Geometry.fromJson(json['geometry']),
        json['formatted_address'],
        json['vicinity'],
    );
  }

}