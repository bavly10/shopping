class Geometry{
  final NewLocation location;

  Geometry({required this.location});
 factory Geometry.fromJson(Map<dynamic,dynamic> parsjson){
   return Geometry(location: NewLocation.fromJson(parsjson["location"]));
  }
}



class NewLocation{
  final double lat,lng;

  NewLocation({required this.lat, required this.lng});
  factory NewLocation.fromJson(Map<dynamic,dynamic> parsedJson){
    return NewLocation(
      lat: parsedJson["lat"],
      lng: parsedJson["lng"],
    );
  }
}

