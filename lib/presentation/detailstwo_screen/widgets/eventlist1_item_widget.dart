import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:flutter/material.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 50),

              Text(organization.title!),
              SizedBox(width: 30), // Aralık için boşluk ekleyebilirsiniz
              Text(organization.city!),
              SizedBox(width: 30), // Aralık için boşluk ekleyebilirsiniz
              Text(""),
            ],
          ),
        ],
      ),
    );
  }
}
