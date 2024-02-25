import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double x;
  final double y;

  const MapScreen({Key? key, required this.x, required this.y}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'), // Başlık olarak "Location" yazısı eklendi
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.x, widget.y),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId('selected-location'),
            position: LatLng(widget.x, widget.y),
            infoWindow: InfoWindow(
              title: 'Selected Location',
              snippet: 'Lat: ${widget.x}, Lng: ${widget.y}',
            ),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Geri dönüş butonunun işlevi eklendi
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
