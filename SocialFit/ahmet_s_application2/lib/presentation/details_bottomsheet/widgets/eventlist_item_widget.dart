import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventlistItemWidget extends StatelessWidget {
  const EventlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 35.v,
          width: 78.h,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgMaterialSymbolsHiking,
                height: 35.adaptSize,
                width: 35.adaptSize,
                alignment: Alignment.centerLeft,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 6.v),
                  child: Text(
                    "Hiking",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgMaterialSymbolsHiking,
                      height: 12.adaptSize,
                      width: 15.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 11.v,
                        bottom: 6.v,
                      ),
                      child: Text(
                        "Hiking",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
