
class Loc
{
  final double lat;
  final double long;

  Loc(this.lat,this.long);

   factory Loc.fromJson(Map<dynamic,dynamic> parsedJson){
    return Loc(
        parsedJson['lat'],
        parsedJson['lng']
    );
  }
}