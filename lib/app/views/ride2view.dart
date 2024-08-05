// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:speed_meter_app/app/controllers/ride2_controller.dart';

// class TaxiFareView extends StatelessWidget {
//   final TaxiFareController controller = Get.put(TaxiFareController());

//   TaxiFareView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('SpeeXo Drive')),
//       body: Stack(
//         children: [
//           Obx(() {
//             return GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: controller.currentPosition.value ?? const LatLng(0, 0),
//                 zoom: 14.0,
//               ),
//               mapType: MapType.normal,
//               markers: Set<Marker>.of(controller.markers),
//               polylines: Set<Polyline>.of(controller.polylines),
//               myLocationEnabled: true,
//             );
//           }),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: Obx(() {
//               return Text(
//                 'Fare: \$${controller.fare.value.toStringAsFixed(2)}',
//                 style: const TextStyle(fontSize: 20, color: Colors.black),
//               );
//             }),
//           ),
//           Positioned(
//             bottom: 80,
//             left: 20,
//             child: Obx(() {
//               return Text(
//                 'Distance: ${controller.totalDistance.value.toStringAsFixed(2)} km',
//                 style: const TextStyle(fontSize: 20, color: Colors.black),
//               );
//             }),
//           ),
//           Positioned(
//             bottom: 50,
//             left: 20,
//             child: Obx(() {
//               return Text(
//                 'Waiting Time: ${controller.waitingTime.value.toStringAsFixed(0)} sec',
//                 style: const TextStyle(fontSize: 20, color: Colors.black),
//               );
//             }),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Obx(() =>
//             Icon(controller.isTracking.value ? Icons.stop : Icons.play_arrow)),
//         onPressed: () {
//           if (controller.isTracking.value) {
//             controller.stopTracking();
//           } else {
//             controller.startTracking();
//           }
//         },
//       ),
//     );
//   }
// }
