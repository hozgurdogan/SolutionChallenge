
import 'package:ahmet_s_application2/core/app_export.dart';
  import 'package:flutter/material.dart';
  import 'package:logger/logger.dart';
  import '../../models/Organization.dart';
  import '../../service/OrganizationService.dart';
  import '../../widgets/app_bar/appbar_trailing_image.dart';
  import '../../widgets/app_bar/custom_app_bar.dart';
  import '../../widgets/custom_bottom_bar.dart';

  import '../profile_screen/profile.dart';

  class AcceptEvent extends StatefulWidget {
    final String organizationId;

    AcceptEvent({required this.organizationId});

    @override
    State<AcceptEvent> createState() => _AcceptEventState();
  }

  class _AcceptEventState extends State<AcceptEvent> {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey();

     late Future<Organization?> _organizationFuture;

    @override
    void initState() {
      super.initState();
      _organizationFuture = OrganizationService().getParticipantByOrganizationId(organizationId: widget.organizationId);
      var log =Logger();
      log.d("had"+_organizationFuture.toString());

    }

    PreferredSizeWidget _buildAppBar(BuildContext context) {
      return CustomAppBar(
        title: GestureDetector(
          child: Padding(
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                AppbarTrailingImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  margin: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 14.v,
                  ),
                ),

                Spacer(),
              ],
            ),
          ),
        ),
        actions: [
          Row(children: []),
        ],
        styleType: Style.bgFill,
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<Organization?>(
              future: _organizationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Veriler yüklenirken ve future çalışırken yükleme göstergesi göster
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Hata: ${snapshot.error}'),
                  );
                } else {
                  Organization? users = snapshot.data;
                  if (users == null || users.parts.isEmpty) {
                    // Veriler yüklenmiş ancak boş ise veya hata varsa
                    return Center(
                      child: Text('No participants.'),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Text(
                          "Attendants",
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        // Kullanıcıları listelemek için ListView.builder kullanıyoruz
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.parts.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Her bir kullanıcıyı bir kart içinde gösteriyoruz
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(users.participants[index]!.name!),
                                subtitle: Text(users.participants[index]!.email!),
                                trailing: users.parts[index].values.first
                                    ? Text("Approved")
                                    : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: () {
                                        setState(() {
                                          users.parts[index][users
                                              .parts[index].keys.first] = true;
                                        });
                                        OrganizationService()
                                            .acceptUserToOrganization(users,
                                            users.parts[index].keys.first);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        
                                        // Reddetme işlevselliğini uygulayın (gerekirse)
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 29.h, right: 26.h),
            child: _buildBottomBar(context)),
      );
    }

    Widget _buildBottomBar(BuildContext context) {
      return CustomBottomBar(onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
      });
    }
  }
