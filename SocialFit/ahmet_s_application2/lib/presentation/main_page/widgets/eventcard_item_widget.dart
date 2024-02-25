import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/presentation/detailstwo_screen/detailstwo_screen.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../models/InfoUser.dart';
import '../../joined.activities/joined_activities.dart';
class EventcardItemWidget extends StatelessWidget {
  const EventcardItemWidget({Key? key, Organization? organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Organization>>(
      future: OrganizationService().getAllOrganization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veri yüklenene kadar yükleniyor göstergesi göster.
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hata varsa hata mesajını göster.
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else {
          return Column(
            children: snapshot.data?.map((organization) {
              return Align(
                alignment: Alignment.center,

                child: Container(
                  height: 150,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: AppDecoration.fillBrownL.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder20,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: organization.getImage(),
                   width: 160,
                        height: 140,
                        radius: BorderRadius.circular(
                          10.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 7.h,
                          top: 10.v,
                          bottom: 7.v,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 16.h),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    organization.title!,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 11.v),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 1.h,
                                    top: 4.v,
                                    bottom: 3.v,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range, size: 15),
                                      Text(
                                        DateFormat.yMMMM()
                                            .format(organization.startDate!)+"-"+
                                         DateFormat.yMMMM()
                                            .format(organization.endDate!),
                                        style: TextStyle(fontSize: 7),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 1.v,
                                    bottom: 3.v,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_city_outlined, size:15),
                                      Text(
                                        organization.city! + "/" + organization.town!,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 125.h,
                              margin: EdgeInsets.only(right: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 1.v, left: 0.v),
                                    child: Row(
                                        children: [
                                          Icon(Icons.access_time, size: 15),
                                          Text(
                                            DateFormat.Hm()
                                                .format(organization.startDate!),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 0.h,
                                    ),
                                    child: Row(
                                        children: [
                                          Icon(Icons.star, size: 15),
                                          Text(
                                            organization.score!.toString() + " Point",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            SizedBox(
                              width: 160.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: 1.v,
                                        right: 6.h,
                                      ),
                                      padding: EdgeInsets.all(4.h),
                                      decoration:
                                      AppDecoration.fillGray.copyWith(
                                        borderRadius:
                                        BorderRadiusStyle.roundedBorder12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            child: Text(
                                              "Details",
                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                                            ),
                                            onTap: () {
                                              var log=Logger();
                                              log.d("ol ol"+organization.id!);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailstwoScreen(
                                                              organizationID:
                                                              organization.id)));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomElevatedButton(
                                      width: 10,
                                      onPressed: () async {
                                        final tempData = await OrganizationService().getOrganizationDetail(organizationId: organization.id!);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                JoinedActivitiesScreen(
                                                  title: tempData!.title ?? 'No Title',
                                                  id: tempData.id ?? 'No ID',
                                                  score: tempData.score ?? 0,
                                                  description: tempData.description ?? 'No Description',
                                                  city: tempData.city ?? 'No City',
                                                  town: tempData.town ?? 'No Town',
                                                  user: tempData.user ?? InfoUser(),
                                                  startDate: tempData.startDate ?? DateTime.now(),
                                                  endDate: tempData.endDate ?? DateTime.now(),
                                                  latitude: tempData?.latitude,
                                                  longitude: tempData?.longitude,
                                                ),
                                          ),
                                        );
                                      },
                                      height: 22.v,
                                      text: "Join",
                                      margin: EdgeInsets.only(left: 1.h),

                                      buttonTextStyle: TextStyle(color: HexColor("CCC5B9")),
                                      buttonStyle: ElevatedButton.styleFrom(

                                        primary: HexColor("EB5E28"), // Arka plan rengi siyah olarak ayarlandı.
                                      ),                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList() ?? [],
          );
        }
      },
    );
  }
}