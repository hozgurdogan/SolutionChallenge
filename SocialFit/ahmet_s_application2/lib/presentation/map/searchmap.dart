import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';


class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String googleApikey = "AIzaSyB18SvHHof2W6vuDUlgpQ2Q7nCkh8ozwF8";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(40.6602292, 30.308027);
  String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Place Search Autocomplete Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition( //innital position in map
                  target: startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),



              //search autoconplete input
              Positioned(  //search input bar
                  top:10,
                  child: InkWell(
                      onTap: () async {
                        var place ;

                        if(place != null){
                          setState(() {
                            location = place.description.toString();
                          });

                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(apiKey:googleApikey,
                            apiHeaders: await GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail = await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);


                          //move map camera to selected place with animation
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                        }
                      },
                      child:Padding(
                        padding: EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                title:Text(location, style: TextStyle(fontSize: 18),),
                                trailing: Icon(Icons.search),
                                dense: true,
                              )
                          ),
                        ),
                      )
                  )
              )


            ]
        )
    );
  }
}