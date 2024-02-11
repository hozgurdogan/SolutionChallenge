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
    return ClipRRect(
      borderRadius: BorderRadius.circular(70), // İstediğiniz border radius değerini burada belirleyin
      child: SizedBox(
        height: 300,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.x, widget.y), // Belirtilen koordinatlara odaklanan kamera pozisyonu
            zoom: 16, // Yakınlık seviyesi
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: {
            Marker(
              markerId: MarkerId('selected-location'),
              position: LatLng(widget.x, widget.y), // İşaretlenen konumun koordinatları
              infoWindow: InfoWindow(
                title: 'Selected Location',
                snippet: 'Lat: ${widget.x}, Lng: ${widget.y}', // İşaretlenen konumun bilgileri
              ),
            ),
          },
        ),
      ),
    );
  }
}
