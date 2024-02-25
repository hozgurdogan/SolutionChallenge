import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Eventlist1ItemWidget extends StatelessWidget {
  final Organization organization;

  const Eventlist1ItemWidget({Key? key, required this.organization})
      : super(key: key);

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
              Icon(Icons.info_outline, size: 25, color: Colors.red),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            organization.title!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.star, size: 17, color: Colors.black),
                        Text(
                          organization.score!.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      organization.city! + "/" + organization.town!,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

