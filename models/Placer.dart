
import './Geometry.dart';
class Placer
{
  final Geometry geometry;
 
  
  Placer(this.geometry);
  
  factory Placer.fromJson(Map<String,dynamic> json)
  {
     return Placer(
        Geometry.fromJson(json['geometry']),
       
    );
  }

}