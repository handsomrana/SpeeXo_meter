import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/views/home_view.dart';
import 'package:speed_meter_app/app/views/login_view.dart';
import 'package:speed_meter_app/app/views/ride2view.dart';
import 'package:speed_meter_app/app/views/ride_view.dart';
import 'package:speed_meter_app/app/widgets/ride_overlay_widget.dart';

// overlay entry point
// @pragma("vm:entry-point")
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RideOverlay(),
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
      home: RideView(),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/home', page: () => HomeView()),
      ],
    );
  }
}
