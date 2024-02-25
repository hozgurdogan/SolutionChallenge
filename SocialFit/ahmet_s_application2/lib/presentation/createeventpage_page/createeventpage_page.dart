import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../profile_screen/profile.dart';
import '../sucssesedCreateEvent/sucssesedCreateEvent.dart';

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
  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
 bool isLoading = false;
  bool isSuccess = true;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _mapInteractionEnabled = false;

  final OrganizationService _eventService = OrganizationService();

  String eventTitle = '';
  String town = '';

  String eventScore = '';
  String eventDescription = '';
  String eventCity = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: _buildAppBar(context),

      body:   SingleChildScrollView(
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
              _buildTextFormField(
                'Event Title',
                    (value) {
                  eventTitle = value;
                },
                errorText: eventTitle.isEmpty ? 'Please enter event title' : null,
              ),
              SizedBox(height: 10),
              _buildTextFormField(
                'Event Score',
                    (value) {
                  eventScore = value;
                },
                keyboardType: TextInputType.number,
                errorText: eventScore.isEmpty ? 'Please enter event score' : null,
              ),
              SizedBox(height: 10),
              _buildTextFormField(
                'Event Description',
                    (value) {
                  eventDescription = value;
                },
                errorText: eventDescription.isEmpty ? 'Please enter event description' : null,
              ),
              SizedBox(height: 15),
              _buildTextFormField(
                'City',
                    (value) {
                  eventCity = value;
                },
                errorText: eventCity.isEmpty ? 'Please enter city' : null,
              ),
              _buildTextFormField(
                'Town',
                    (value) {
                  town = value;
                },

                errorText: eventCity.isEmpty ? 'Please enter town' : null,
              ),
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(20.0),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.all(20.0),
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
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade500,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  if (_validateInputs()) {
                    setState(() {
                      isLoading = true; // Loading işareti göster
                    });

                    String? currentUserUid = await _auth.currentUser?.uid;
                    if (currentUserUid != null) {
                      Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );
                      LatLng userLocation = LatLng(position.latitude, position.longitude);

                      bool result = await _eventService.registerEvent(
                        title: eventTitle,
                        score: int.parse(eventScore),
                        description: eventDescription,
                        city: eventCity,
                        town: town,
                        startDate: _startDate,
                        endDate: _endDate,
                        latitude: userLocation.latitude,
                        longitude: userLocation.longitude,
                        participants: [],
                        partts: [],
                        userId: currentUserUid,
                      );

                      if (result) {
                        // Başarıyla etkinlik oluşturulduğunda yeni sayfaya geç
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SuccessCreateEvent()),
                        );
                      } else {
                        // Hata durumunda uyarı göster
                        _showSnackBar('Error while creating event');
                      }
                    }
                  }
                },
                child: Text(
                  'Create',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),

            ],
          ),

        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),

      );


  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 60.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 36.h, top: 16.v, bottom: 13.v),
            onTap: () {
             onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotificationsTeal200,
              margin: EdgeInsets.symmetric(horizontal: 43.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }


  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
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

  Widget _buildTextFormField(
      String label,
      Function(String) onChanged, {
        TextInputType keyboardType = TextInputType.text,
        String? errorText,
      }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: errorText != null ? Colors.red : Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        errorText: errorText,
        fillColor: Colors.white,
        filled: true,
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildDateTimeField(String label, bool isStartDate) {
    String formattedDateTime =
    isStartDate ? _formatDateTime(_startDate) : _formatDateTime(_endDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: formattedDateTime,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () => _selectDateTime(context, isStartDate),
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
        initialTime: TimeOfDay.fromDateTime(
            isStartDate ? _startDate : _endDate),
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

  bool _validateInputs() {
    String? errorText;
    if (eventTitle.isEmpty) {
      errorText = 'Please enter event title';
    } else if (eventScore.isEmpty) {
      errorText = 'Please enter event score';
    } else if (eventDescription.isEmpty) {
      errorText = 'Please enter event description';
    } else if (eventCity.isEmpty) {
      errorText = 'Please enter city';
    }

    if (errorText != null) {
      _showSnackBar(errorText);
      return false;
    }

    return true;
  }
}

class MapPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 60.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 36.h, top: 16.v, bottom: 13.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotificationsTeal200,
              margin: EdgeInsets.symmetric(horizontal: 43.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }


}
