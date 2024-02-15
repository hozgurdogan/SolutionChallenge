import 'package:ahmet_s_application2/presentation/map/locationMap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/UserInfo.dart';
import '../../service/OrganizationService.dart';
import '../../service/UserService.dart';

class JoinedActivitiesScreen extends StatelessWidget {
  final String id;
  final int score;
  final String title;
  final String description;
  final String city;
  final String town;
  final dynamic user;
  final DateTime startDate;
  final DateTime endDate;
  final double? latitude;
  final double? longitude;

  JoinedActivitiesScreen({
    required this.id,
    required this.score,
    required this.title,
    required this.description,
    required this.city,
    required this.town,
    required this.user,
    required this.startDate,
    required this.endDate,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    String latituderAsString = latitude.toString();
    String longitudeAsString = longitude.toString();

    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      OrganizationService().joinOrganization(id);
    });

    final userService = UserService();
    final userInfoFuture = userService.getUserInfoByEmail();

    return FutureBuilder(
      future: userInfoFuture,
      builder: (context, AsyncSnapshot<InfoUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final userInfo = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Joined Activities'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 200,
                    ),
                    Text(
                      'Activity joined successfully!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                  
                    SizedBox(height: 20),
                    Text(
                      'Activity Name: $title',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description: $description',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'City: $city',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Town: $town',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Start Date: ${dateFormat.format(startDate)} ${timeFormat.format(startDate)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'End Date: ${dateFormat.format(endDate)} ${timeFormat.format(endDate)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'User Name: ${userInfo?.name ?? ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'User Surname: ${userInfo?.surname ?? ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.greenAccent,
                              elevation: 3,
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text('Back to Home'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (latitude != null && longitude != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                      x: latituderAsString as double,
                                      y: longitudeAsString as double,
                                    ),
                                  ),
                                );
                              } else {
                                // Varsayılan bir konum atanabilir veya bir uyarı gösterilebilir.
                                print('Latitude or longitude is null.');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              elevation: 3,
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text('Haritadan Gör'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
