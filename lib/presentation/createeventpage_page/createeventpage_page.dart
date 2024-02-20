import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/UserInfo.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.blueGrey[800],
      hintColor: Colors.tealAccent[400],
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.white),
      ),
    ),
    home: CreateEventPage(),
  ));
}

class CreateEventPage extends StatefulWidget {
  const CreateEventPage();

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _mapInteractionEnabled = false;

  final OrganizationService _eventService = OrganizationService();

  String eventTitle = '';
  String eventScore = '';
  String eventDescription = '';
  String eventCity = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Event Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildTextFormField('Event Title', (value) {
                eventTitle = value;
              }),
              SizedBox(height: 10),
              _buildTextFormField('Event Score', (value) {
                eventScore = value;
              }),
              SizedBox(height: 10),
              _buildTextFormField('Event Description', (value) {
                eventDescription = value;
              }),
              SizedBox(height: 10),
              _buildTextFormField('City', (value) {
                eventCity = value;
              }),
              SizedBox(height: 10),
              SizedBox(height: 20),
              _buildDateTimeField('Start Date', true),
              SizedBox(height: 10),
              _buildDateTimeField('End Date', false),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showMapPicker(context);
                      },
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),

                      label: Text(
                      'Set Event Location on Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,

                      ),
                    ),

                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showUserLocation();
                      },
                      icon: Icon(
                        Icons.gps_fixed,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Use Current Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (!_mapInteractionEnabled) {
                    setState(() {
                      _mapInteractionEnabled = true;
                    });
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    onTap: _mapInteractionEnabled ? _onMapTap : null,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      zoom: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () async {
            String? currentUserUid = await _auth.currentUser?.uid;
            if (currentUserUid != null) {
              Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );
              LatLng userLocation = LatLng(position.latitude, position.longitude);

              _eventService.registerEvent(
                title: eventTitle,
                score: int.parse(eventScore),
                description: eventDescription,
                city: eventCity,
                town: 'Köy',
                startDate: _startDate,
                endDate: _endDate,
                latitude: userLocation.latitude,
                longitude: userLocation.longitude,
                participants: [],
                partts: [],
                userId: currentUserUid,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Current user not found')),
              );
            }
          },
          child: Text('Create'),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTap(LatLng latLng) {
    if (_mapInteractionEnabled) {
      _addMarker(latLng);
    }
  }

  void _addMarker(LatLng latLng) {
    final MarkerId markerId = MarkerId('selected_location');
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
    );

    setState(() {
      _markers.clear();
      _markers.add(marker);
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 15),
      );
    }
  }

  Widget _buildTextFormField(String label, Function(String) onChanged,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildDateTimeField(String label, bool isStartDate) {
    String formattedDateTime = isStartDate ? _formatDateTime(_startDate) : _formatDateTime(_endDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _selectDateTime(context, isStartDate),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: Text(
            'Selected Date and Time: $formattedDateTime',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(isStartDate ? _startDate : _endDate),
      );

      if (pickedTime != null) {
        final selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStartDate) {
            _startDate = selectedDateTime;
          } else {
            _endDate = selectedDateTime;
          }
        });
      }
    }
  }

  Future<void> _showMapPicker(BuildContext context) async {
    LatLng? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapPickerPage(),
      ),
    );

    if (selectedLocation != null) {
      _addMarker(selectedLocation);
    }
  }

  void _showUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng userLocation = LatLng(position.latitude, position.longitude);
    _addMarker(userLocation);
  }
}

class MapPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 15,
        ),
        onTap: (LatLng latLng) {
          Navigator.of(context).pop(latLng);
        },
      ),
    );
  }
}
