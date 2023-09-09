import 'package:geolocator/geolocator.dart';

class Geoservice
{
  Future<Position> getcurrentloc() async{
    
    var permission = await Geolocator.requestPermission();
  
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    
  }
  
}