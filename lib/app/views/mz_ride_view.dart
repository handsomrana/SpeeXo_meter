import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/mz_ride_controller.dart';

class MzRideView extends StatelessWidget {
  MzRideView({super.key});
  final MzRideController controller = Get.put(MzRideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bike Tracker')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Column(
                  children: [
                    const Text("Geolocator"),
                    const SizedBox(height: 20),
                    Text(
                        'Geolocator Speed: ${controller.speedGeolocator.value.toStringAsFixed(2)} km/h'),
                    Text(
                        'Geolocator Distance: ${controller.totalDistanceGeolocator.value.toStringAsFixed(2)} km'),
                    Text(
                        'Geolocator Fare: \$${controller.fareGeolocator.value.toStringAsFixed(2)}'),
                    const SizedBox(height: 20),
                    const Text("Google API"),
                    const SizedBox(height: 20),
                    Text(
                        'Google API Speed: ${controller.speedGoogleAPI.value.toStringAsFixed(2)} km/h'),
                    Text(
                        'Google API Distance: ${controller.totalDistanceGoogleAPI.value.toStringAsFixed(2)} km'),
                    Text(
                        'Google API Fare: \$${controller.fareGoogleAPI.value.toStringAsFixed(2)}'),
                  ],
                )),
          ),
          ElevatedButton(
            onPressed: controller.startRide,
            child: const Text('Start Ride'),
          ),
          ElevatedButton(
            onPressed: controller.stopRide,
            child: const Text('Stop Ride'),
          ),
        ],
      ),
    );
  }
}
