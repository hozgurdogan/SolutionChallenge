import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';

class Analyze extends StatefulWidget {
  const Analyze();

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Profil Sayfası'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50, // Profil resmi boyutu artırıldı
                backgroundImage: AssetImage('assets/avatar.png'), // Profil resmi
              ),
              SizedBox(height: 10),
              Text(
                'İsim Soyisim', // İsim soyisim
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatContainer('Kalori', '0', Colors.green),
                  _buildStatContainer('Adım', '0', Colors.green),
                ],
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Etkinlik Bilgileri', // Etkinlik bilgileri başlığı
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _buildActivityInfo('Etkinlik Adı', 'Flutter Workshop'),
                      _buildActivityInfo('Skor', '85'),
                      _buildActivityInfo('Şehir', 'İstanbul'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatContainer(String title, String count, Color color) {
    return Container(
      width: 120, // Container genişliği artırıldı
      height: 120, // Container yüksekliği artırıldı
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            count,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title + ':',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
