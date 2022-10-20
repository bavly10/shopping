import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shopping/modules/Map/location_helpr.dart';


class Maps extends StatefulWidget {

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  static  Position position="" as Position;
  Completer<GoogleMapController> mapController=Completer();
  late StreamSubscription locationSubscription;
  static final CameraPosition _myCurrnet= CameraPosition(target: LatLng(position.latitude,position.longitude),bearing: 0.0,tilt: 0,zoom:10);
  final Set<Marker> _markers={};

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  buildMap(),
        floatingActionButton: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: (){
              _gotoMyCurrnet();
            },
            child: Icon(Icons.place_outlined,color: Colors.white,),
          ),
        ),
      ),
    );
  }


  Future<void> getMyCurrentLocation()async{
    position=  await LocationHelpr.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }
  Widget buildMap(){
    return SizedBox(
      height: 450,
      child: GoogleMap(
        initialCameraPosition: _myCurrnet,
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        markers: _markers,
        onMapCreated: (GoogleMapController controller){
          mapController.complete(controller);
        },
      ),
    );
  }
  Future<void> _gotoMyCurrnet()async{
    final GoogleMapController controller=await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCurrnet));
  }
}
