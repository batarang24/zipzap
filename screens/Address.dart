import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zipzap/providers/geoprovider.dart';
import '../models/Place.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
 StreamSubscription ? locationSubscription;
  

  final TextEditingController _area=TextEditingController();
  Completer<GoogleMapController >controller =Completer();

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  
  }
 
 
    @override
  void dispose() {
    
    //geobloc.dispose();
    _area.dispose();
    
    
    //controller=null;
    locationSubscription!.cancel();
    
    //geobloc.selectedLocation.close();
 
    super.dispose();
  }
   bool map=false;
  @override
  Widget build(BuildContext context) {
    
    final geobloc=Provider.of<Geobloc>(context);
    geobloc.setcurrentlocation();
    print(geobloc.currentloc);
    return Scaffold(
      
      body: Container(
        child: Stack(
          children: [
            
            Container(
          //height: 300,
          child: geobloc.currentloc==null?
          Center(child: CircularProgressIndicator(),):
          
          GoogleMap(
            mapType: MapType.terrain,
            myLocationEnabled: true,
           
            initialCameraPosition:CameraPosition(
              target: LatLng(geobloc.currentloc!.latitude,geobloc.currentloc!.longitude),
              zoom: 14
            ) ,
            onMapCreated: (controls) async{
             await geobloc.setmarker(geobloc.currentloc!.latitude,geobloc.currentloc!.longitude);
             await geobloc.latlonger(geobloc.currentloc!.latitude,geobloc.currentloc!.longitude);
              //await  geobloc.mapchanger();
              controller.complete(controls);
              setState(() {
                map=true;
              });
              
             
            },
           onTap: (pos) async{
             
             // gotoplace1(pos);
              //await geobloc.setmarker(pos.latitude,pos.longitude);
            

            },
            myLocationButtonEnabled: true,
            
             markers: Set<Marker>.of(geobloc.list)
          ),
          
        ),
       if( geobloc.autosearchers!.isNotEmpty) Container(
          margin: EdgeInsets.only(top: 90,left: 20,right: 20),
         // color: Colors.black,
          height: 350,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 239, 239, 239)
          ),
          child: ListView.builder(
            itemCount: geobloc.autosearchers?.length,
            itemBuilder:(context, index) {
              return Column(
                children: [
                   ListTile(title:Text(geobloc.autosearchers![index].description), onTap:() async{
                await geobloc.setSelectedLocation(geobloc.autosearchers![index].placeid);
                
                if ( geobloc.selectedLocationStatic!=null)  {
                  _area.text=geobloc.selectedLocationStatic!.name;
                  gotoplace( geobloc.selectedLocationStatic);
                }
                else
                {
                  print('((((((((((((((((((((((((((()))))))))))))))))))))))))))');
                }
              }),
              Divider()
                ],
              );
            
            },

          )
        ),
        
        Container(
          margin: EdgeInsets.only(top: 60,left: 10,right: 10),
          child: TextField(
          controller: _area,
          onChanged: (value) async{
           
            if (value!="") {
              await geobloc.autoplaces(value);
            }
            
          },
          decoration:InputDecoration(
            contentPadding: EdgeInsets.all(10),
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40)
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search your place'
            
           
            //colo
          ),
        ),
        ),
        //Spacer(),
        
          ],
        ),
      ),
    
      bottomNavigationBar:map?Container(height: 150,
      width:MediaQuery.of(context).size.width,
      //color: Colors.purple,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(geobloc.selectedLocationStatic!.name),
          Divider(),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed(
              'addreg',
              arguments: {
                'loc':geobloc.selectedLocationStatic!.name,
                'lat':geobloc.selectedLocationStatic!.geometry.location.lat,
                'long':geobloc.selectedLocationStatic!.geometry.location.long
              }
            );
          }, child: Text('Continue with this address'),style: 
          
          ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(40)
            
          ),)
        ],
      ),
      )
      
      ):Container(height: 100,)
    );
    
  }
  Future<void> gotoplace(Place ? place) async{
    
    
      final GoogleMapController control= await controller.future;
      control.animateCamera(
        
        CameraUpdate.newCameraPosition(
          
          CameraPosition(
            target: LatLng(
              place!.geometry.location.lat,place.geometry.location.long
            ),
            zoom: 15,
            
          ),
          
        )
      );
  }
  Future<void> gotoplace1(LatLng pos) async{
      final GoogleMapController control= await controller.future;
      control.animateCamera(
        
        CameraUpdate.newCameraPosition(
          
          CameraPosition(
            target: LatLng(
              pos.latitude,pos.longitude
            ),
            zoom: 15,
            
          ),
          
        )
      );
  }

}