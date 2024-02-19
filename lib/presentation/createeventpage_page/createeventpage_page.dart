import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage();

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 54.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 30.h, top: 13.v, bottom: 16.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotifications,
              margin: EdgeInsets.symmetric(horizontal: 28.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }
  TextEditingController _locationController = TextEditingController();
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Event Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildTextFormField('Event Title'),
              SizedBox(height: 10),
              _buildTextFormField('Event Score'),
              SizedBox(height: 10),
              _buildDateTimeField('Start Date', true),
              SizedBox(height: 10),
              _buildDateTimeField('End Date', false),
              SizedBox(height: 10),
              _buildTextFormField('City'),
              SizedBox(height: 10),
              _buildLocationField(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Etkinliği oluştur
                },
                child: Text('Create'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  Widget _buildTextFormField(String label,
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
    );
  }

  Widget _buildDateTimeField(String label, bool isStartDate) {
    return InkWell(
      onTap: () => _selectDateTime(context, isStartDate),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
            // Başlangıç tarihi buraya yazılacak
          } else {
            // Bitiş tarihi buraya yazılacak
          }
        });
      }
    }
  }

  Widget _buildLocationField() {
    return TextFormField(
      controller: _locationController,
      decoration: InputDecoration(
        labelText: 'Location',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            Prediction? prediction = await PlacesAutocomplete.show(
              context: context,
              apiKey: 'AIzaSyB18SvHHof2W6vuDUlgpQ2Q7nCkh8ozwF8',
              mode: Mode.overlay,
              language: 'en',
              components: [Component(Component.country, 'us')],
            );

            if (prediction != null) {
              _locationController.text = prediction.description!;
              _addMarker(prediction.placeId!);
            }
          },
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
    );
  }

  void _addMarker(String placeId) async {
    final places = GoogleMapsPlaces(apiKey: 'AIzaSyB18SvHHof2W6vuDUlgpQ2Q7nCkh8ozwF8');

    PlacesDetailsResponse place = await places.getDetailsByPlaceId(placeId);
    final lat = place.result.geometry!.location.lat;
    final lng = place.result.geometry!.location.lng;

    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(placeId),
        position: LatLng(lat, lng),
      ));
    });

    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    }
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
