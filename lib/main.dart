import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speed_meter_app/app/services/background_services.dart';
import 'package:speed_meter_app/app/views/home_view.dart';
import 'package:speed_meter_app/app/views/login_view.dart';
import 'package:speed_meter_app/app/views/ride_view.dart';
import 'package:speed_meter_app/app/views/speed_view.dart';

// overlay entry point
@pragma("vm:entry-point")
void overlayMain() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Permission.notification.isDenied.then(
  //   (value) {
  //     if (value) {
  //       Permission.notification.request();
  //     }
  //   },
  // );
  // await initializeBackgroundService();
  runApp(const CarRentalApp());
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
      home: RideView(),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/home', page: () => HomeView()),
      ],
    );
  }
}
