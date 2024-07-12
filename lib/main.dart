import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/views/home_view.dart';
import 'package:speed_meter_app/app/views/login_view.dart';
import 'package:speed_meter_app/app/views/ride_view.dart';

void main() => runApp(const CarRentalApp());

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RideView(),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/home', page: () => HomeView()),
      ],
    );
  }
}
