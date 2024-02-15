import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/presentation/detailstwo_screen/detailstwo_screen.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../models/UserInfo.dart';
import '../../joined.activities/joined_activities.dart';

// ignore: must_be_immutable
class EventcardItemWidget extends StatelessWidget {
  const EventcardItemWidget({Key? key, Organization? organization})
      : super(
          key: key,
        );

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
          return ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: AppDecoration.fillGray300.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder20,
                    ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle14,
                          height: 120.v,
                          width: 150.h,
                          radius: BorderRadius.circular(
                            10.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 7.h,
                            top: 7.v,
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
                                      snapshot.data![index].title!,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 11.v),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath:
                                        ImageConstant.imgFluentMdl2DateTime,
                                    height: 15.adaptSize,
                                    width: 15.adaptSize,
                                    margin: EdgeInsets.only(top: 1.v),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 1.h,
                                      top: 1.v,
                                      bottom: 3.v,
                                    ),
                                    child: Text(
                                      DateFormat.yMMMM().format(snapshot.data![index].startDate!),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgCodiconLocation,
                                    height: 15.adaptSize,
                                    width: 15.adaptSize,
                                    margin: EdgeInsets.only(left: 5.h),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 1.v,
                                      bottom: 3.v,
                                    ),
                                    child: Text(
                                      snapshot.data![index].town!,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.v),
                              Container(
                                width: 125.h,
                                margin: EdgeInsets.only(right: 15.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 4.v, left: 15.v),
                                      child: Text(
                                        DateFormat.Hm().format(
                                            snapshot.data![index].startDate!),
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    Spacer(),
                                    // CustomImageView(
                                    //   imagePath: ImageConstant.imgHealthiconsAwa,
                                    //   height: 15.adaptSize,
                                    //   width: 15.adaptSize,
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 4.v,
                                        bottom: 3.v,
                                      ),
                                      child: Text(
                                        snapshot.data![index].score!
                                                .toString() +
                                            " Puan",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.v),
                              SizedBox(
                                width: 150.h,
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
                                                "Detay Gör",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailstwoScreen(
                                                                organizationID:
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id)));
                                              },
                                            ),
                                            // CustomImageView(
                                            //   onTap: () => {
                                            //
                                            //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailstwoScreen(organizationID:snapshot.data![index].id!,
                                            //   ),))
                                            //   },
                                            //   placeHolder: "Tıkla",
                                            //   imagePath: ImageConstant.imgVector,
                                            //   height: 20.adaptSize,
                                            //   width: 20.adaptSize,
                                            //   margin: EdgeInsets.only(bottom: 2.v),
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(bottom: 2.v),
                                            //   child: Text(
                                            //     "Details",
                                            //     style: CustomTextStyles.bodySmall10,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        onPressed: (){

                                          final tempData = snapshot.data![index];
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => JoinedActivitiesScreen(
                                                title: tempData.title ?? 'No Title',
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
                                        height: 25.v,
                                        text: "Join",
                                        margin: EdgeInsets.only(left: 6.h),
                                        leftIcon: Container(
                                          margin: EdgeInsets.only(right: 4.h),
                                          child: CustomImageView(
                                            imagePath:
                                            ImageConstant.imgFluentarrowjoin20regular,
                                            height: 15.adaptSize,
                                            width: 15.adaptSize,
                                          ),
                                        ),
                                        buttonTextStyle: CustomTextStyles.bodySmall10,
                                      ),
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
              }
              // Dikey eksen boyunca kartları hizalamak için kullanılır
              // Dikey eksenin yüksekliğini alana kadar kartların genişlemesini sağlar

              );
        }
      },
    );
  }
}
