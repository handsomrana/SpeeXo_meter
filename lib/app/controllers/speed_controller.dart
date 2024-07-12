// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import '../models/speed_model.dart';

// class SpeedController extends GetxController {
//   var speedModel = SpeedModel().obs;
//   StreamSubscription<Position>? _positionStreamSubscription;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   Future<void> startTracking() async {
//     errorMessage.value = '';

//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         throw Exception('Location services are disabled.');
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           throw Exception('Location permissions are denied.');
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         throw Exception(
//             'Location permissions are permanently denied, we cannot request permissions.');
//       }

//       _positionStreamSubscription = Geolocator.getPositionStream(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.best,
//           distanceFilter: 5,
//         ),
//       ).listen(
//         (Position position) {
//           speedModel.update((model) {
//             model!.speed = position.speed;
//           });
//         },
//         onError: (error) {
//           errorMessage.value = 'Error occurred: $error';
//         },
//       );
//     } catch (e) {
//       errorMessage.value = 'Exception: $e';
//     }
//   }

//   void stopTracking() {
//     _positionStreamSubscription?.cancel();
//     speedModel.update((model) {
//       model!.speed = 0.0;
//     });
//   }

//   @override
//   void onClose() {
//     _positionStreamSubscription?.cancel();
//     super.onClose();
//   }
// }
