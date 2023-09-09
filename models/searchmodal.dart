class Searchmodal
{
  final String description;
  final String placeid;

  Searchmodal(this.description,this.placeid);

  factory Searchmodal.fromJson(Map<String,dynamic> json){
      return Searchmodal(
        json['description'],
        json['placeid']
      );
  }
}