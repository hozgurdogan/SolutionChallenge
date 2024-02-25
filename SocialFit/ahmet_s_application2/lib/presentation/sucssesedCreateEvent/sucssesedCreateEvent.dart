import 'package:flutter/material.dart';
import '../main_container_screen/main_container_screen.dart';
import '../main_page/main_page.dart';

class SuccessCreateEvent extends StatefulWidget {
  @override
  _SuccessCreateEventState createState() => _SuccessCreateEventState();
}

class _SuccessCreateEventState extends State<SuccessCreateEvent> {
  @override
  void initState() {
    super.initState();
    // 3 saniye sonra yönlendirme yap
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
        automaticallyImplyLeading: false, // Geri dönüş okunu kaldır
      ),
      body: SingleChildScrollView( // SingleChildScrollView ekleyin
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Event successfully created!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'You have successfully created an event.', // Yeni açıklamalı metin
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(), // Loading çarkı ekle
            ],
          ),
        ),
      ),
    );
  }
}
