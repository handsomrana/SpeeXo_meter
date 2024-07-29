import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/local_database/isar_services.dart';
import 'package:speed_meter_app/app/views/home_view.dart';
import 'package:speed_meter_app/app/views/login_view.dart';
import 'package:speed_meter_app/app/views/mz_ride_view.dart';
import 'package:speed_meter_app/app/widgets/ride_overlay_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final IsarServices isarServices = IsarServices();
  await isarServices.getRides();
  runApp(const CarRentalApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(48, 49, 85, 1)),
      ),
      home: const RideOverlay(),
    ),
  );
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MzRideView(),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/home', page: () => HomeView()),
      ],
    );
  }
}
