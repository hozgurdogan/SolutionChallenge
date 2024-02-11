import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Eventlist1ItemWidget extends StatelessWidget {
  final Organization organization;

  const Eventlist1ItemWidget({Key? key, required this.organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 250,

        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgMaterialSymbolsHiking,
              height: 30.adaptSize,
              width: 30.adaptSize,
              alignment: Alignment.centerLeft,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
Icon(Icons.location_on_outlined,size: 25,color: Colors.red),

                SizedBox(width: 5), // Aralık ekleyin
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(organization.title!,style: TextStyle(fontSize: 20)),
                      Text(organization.city!+"/"+organization.town!,style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
                CustomImageView(
                  color: Colors.red,
                  imagePath: ImageConstant.imgSolarStarBold,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.only(top: 3.v, bottom: 5.v),
                ),

                Text(organization.score!.toString(),
                  style: TextStyle(
                    color: Colors.black, // İstenilen renk
                    fontSize: 18, // İstenilen font büyüklüğü
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //
            //   Text(DateFormat.yMMMM().format(organization.startDate!))
            // ],)

          ],
        ),

      );

  }
}
