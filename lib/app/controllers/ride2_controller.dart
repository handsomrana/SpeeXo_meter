// import 'package:flutter/foundation.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';
// import 'package:speed_meter_app/app/local_database/collections/tunnel_solution_collection.dart';
// import 'package:speed_meter_app/app/local_database/isar_services.dart';
// import 'dart:async';
// import 'package:speed_meter_app/utils/vacent_disatance.dart';

// class RideController extends GetxController {
//   final IsarServices isarServices = IsarServices();
//   double packageCost = 4.92;
//   double movingRate = 2.29;
//   double waitingRate = 0.0158;
//   var selectedPackage = 'DEFAULT'.obs;
//   double extraAmount = 0.0;
//   double tollsAmount = 0.0;
//   bool isTracking = false;
//   bool isMoving = false;
//   bool isPackage1 = false;
//   bool isPackage2 = false;
//   bool isPackage3 = false;
//   bool isTunnel = false;
//   String startAddress = '';
//   String endAddress = '';
//   double speed = 0.0;
//   String startTime = '';
//   String endTime = '';
//   Position? lastPosition;
//   Position? startPosition;
//   double totalDistance = 0.0;
//   double rideDistance = 0.0;
//   double totalFare = 0.0;
//   double waitingFare = 0.0;
//   double movingFare = 0.0;
//   StreamSubscription<Position>? positionStreamSubscription;
//   Timer? updateTimer;
//   int waitingTime = 0;
//   int movingTime = 0;

// // MAIN FUNCTION STARTS

//   Future<void> startTracking() async {
//     if (!(await _checkLocationPermission())) {
//       await _requestLocationPermission();
//     }

//     if (await _checkLocationPermission()) {
//       isTracking = true;
//       isTunnel = false;
//       isMoving = false;
//       startTime = DateTime.now().toString();
//       endTime = '';
//       speed = 0.0;
//       extraAmount = 0.0;
//       tollsAmount = 0.0;
//       startPosition = await Geolocator.getCurrentPosition();
//       lastPosition = null;
//       await savePositionToLocal();
//       waitingTime = 0;
//       movingTime = 0;
//       waitingFare = 0.0;
//       totalDistance = 0.0;
//       rideDistance = 0.0;
//       totalFare = 0.0;
//       movingFare = 0.0;
//       update();
//       positionStreamSubscription = Geolocator.getPositionStream(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//           distanceFilter: 5,
//         ),
//       ).listen((Position position) async {
//         final currentSpeed = position.speed * 3.6;

//         if (lastPosition != null) {
//           isTunnel = false;
//           final distance = vincentyDistance(
//             lastPosition!.latitude,
//             lastPosition!.longitude,
//             position.latitude,
//             position.longitude,
//           );

//           if (currentSpeed >= 1 && currentSpeed < 26) {
//             rideDistance += distance / 1000;
//           } else if (currentSpeed >= 26) {
//             totalDistance += distance / 1000;
//           }

//           speed = currentSpeed;
//           update();
//         } else if (lastPosition == position) {
//           isTunnel = true;
//           update();
//         }
//         lastPosition = position;
//       });

//       updateTimer = Timer.periodic(
//         const Duration(seconds: 1),
//         (timer) async {
//           await savePositionToLocal();
//           if (isTracking) {
//             if (speed < 26) {
//               isMoving = false;
//               waitingTime += 1;
//             } else if (speed >= 26) {
//               isMoving = true;
//               movingTime += 1;
//             }
//             calculateFare();
//             update();
//           }
//         },
//       );
//     } else {
//       if (kDebugMode) {
//         print('Location permission not granted');
//       }
//     }
//   }

// // ENDING THE RIDE
//   void stopTracking() async {
//     await savePositionToLocal();
//     await getDistanceFromLocal();
//     isTracking = false;
//     endTime = DateTime.now().toString();
//     await getAddressFromCoordinates();
//     await addRidetoLocal();
//     positionStreamSubscription?.cancel();
//     updateTimer?.cancel();
//     await isarServices.getRides();
//     await isarServices.deletePositions();
//     update();
//   }

//   @override
//   void onClose() async {
//     positionStreamSubscription?.cancel();
//     updateTimer?.cancel();
//     await isarServices.deletePositions();
//     isTracking = false;
//     isMoving = false;
//     super.onClose();
//   }

//   @override
//   void onInit() async {
//     super.onInit();
//     await isarServices.getRides();
//   }

// // CHECKING LOCATION PERMISSION
//   Future<bool> _checkLocationPermission() async {
//     final permission = await Geolocator.checkPermission();
//     return permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse;
//   }

// // REQUESTING FOR LOCATION PERMISSIONS
//   Future<void> _requestLocationPermission() async {
//     final permission = await Geolocator.requestPermission();
//     if (permission != LocationPermission.always &&
//         permission != LocationPermission.whileInUse) {
//       if (kDebugMode) {
//         print('Location permission denied');
//       }
//     }
//   }

// // FORMATING WAITNG TIME
//   String getFormattedWaitingTime() {
//     final int minutes = waitingTime ~/ 60;
//     final int seconds = waitingTime % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

// // FORMATING MOVING TIME
//   String getFormattedMovingTime() {
//     final int minutes = movingTime ~/ 60;
//     final int seconds = movingTime % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

// // SAVING RIDE HISTORY TO THE LOCAL DATABASE
//   Future<void> addRidetoLocal() async {
//     final newRide = RideCollection(
//         driverId: '001',
//         packageType: isPackage1
//             ? "S1"
//             : isPackage2
//                 ? "S2"
//                 : isPackage3
//                     ? "S3"
//                     : "DEFAULT",
//         startLocation: startAddress,
//         endLocation: endAddress,
//         fare: totalFare.toStringAsFixed(1),
//         distance: totalDistance.toStringAsFixed(1),
//         duration: calculateDuration(startTime, endTime),
//         startTime: startTime,
//         endTime: endTime,
//         tolls: tollsAmount.toStringAsFixed(1),
//         extra: extraAmount.toStringAsFixed(1),
//         status: "COMPLETED");

//     await isarServices.addRide(newRide);
//   }

// // SAVING POSITION IN TO LOCAL DATABASE
//   Future<void> savePositionToLocal() async {
//     final tempcPosition = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );
//     if (!tempcPosition.isMocked) {}
//     final newPosition = TunnelSolutionCollection(
//       positionLatitude: tempcPosition.latitude,
//       positionLongitude: tempcPosition.longitude,
//       timeStamp: DateTime.now(),
//     );
//     await isarServices.addPosition(newPosition);
//   }

// // CALCULATING DISTANCE USING LOCAL DATABASE
//   Future<void> getDistanceFromLocal() async {
//     final positions = await isarServices.getPositions();
//     double temDistance = 0.0;
//     if (positions.isNotEmpty) {
//       for (int i = 0; i < positions.length - 1; i++) {
//         final start = positions[i];
//         final end = positions[i + 1];
//         if (start.positionLatitude == end.positionLatitude &&
//             start.positionLongitude == end.positionLongitude) {
//           continue;
//         }
//         if (start.positionLatitude == 0.0 &&
//             start.positionLongitude == 0.0 &&
//             end.positionLatitude == 0.0 &&
//             end.positionLongitude == 0.0) {
//           continue;
//         }

//         final distance = vincentyDistance(
//           start.positionLatitude,
//           start.positionLongitude,
//           end.positionLatitude,
//           end.positionLongitude,
//         );
//         if (distance > 2) {
//           temDistance += distance / 1000;
//         }
//       }
//       totalDistance = temDistance;
//       update();
//     }
//   }

// // GETTING ADDRESS FROM COORDINATES VALUE
//   Future<void> getAddressFromCoordinates() async {
//     if (startPosition != null && lastPosition != null) {
//       try {
//         await setLocaleIdentifier("en");
//         final List<Placemark> startPlacemarks = await placemarkFromCoordinates(
//           startPosition!.latitude,
//           startPosition!.longitude,
//         );
//         if (startPlacemarks.isNotEmpty) {
//           final Placemark startPlacemark = startPlacemarks.first;
//           startAddress =
//               '${startPlacemark.street}, ${startPlacemark.locality},${startPlacemark.subAdministrativeArea}, ${startPlacemark.administrativeArea}, ${startPlacemark.country}';
//         }

//         final List<Placemark> endPlacemarks = await placemarkFromCoordinates(
//           lastPosition!.latitude,
//           lastPosition!.longitude,
//         );
//         if (endPlacemarks.isNotEmpty) {
//           final Placemark endPlacemark = endPlacemarks.first;
//           endAddress =
//               '${endPlacemark.street}, ${endPlacemark.locality}, ${endPlacemark.administrativeArea}, ${endPlacemark.country}';
//         }
//       } catch (e) {
//         if (kDebugMode) {
//           print('Error occurred while getting address: $e');
//         }
//       }
//     }
//   }

// // ADDING EXTRAS AMOUNT
//   void addExtraAmount(double amount) {
//     extraAmount = amount;
//     update();
//   }

// // ADDING TOLLS AMOUNT
//   void addTollsAmount(double amount) {
//     tollsAmount = amount;
//     update();
//   }

// // FARE CALCULATION FORMULA
//   void calculateFare() {
//     movingFare = totalDistance * movingRate;
//     waitingFare = waitingTime * waitingRate;
//     totalFare =
//         tollsAmount + extraAmount + packageCost + movingFare + waitingFare;
//   }

// // CALCULATING RIDE DURATION
//   String calculateDuration(String start, String end) {
//     if (start.isEmpty || end.isEmpty) return '';
//     final DateTime startTime = DateTime.parse(start);
//     final DateTime endTime = DateTime.parse(end);
//     final Duration duration = endTime.difference(startTime);
//     double totalMinutes = duration.inSeconds / 60.0;
//     return '${totalMinutes.toStringAsFixed(2)} minute';
//   }

// // SETTING PACKAGE 1
//   void setPackage1() {
//     waitingRate = 0.01583;
//     movingRate = 2.29;
//     packageCost = 4.92;
//     isPackage1 = true;
//     selectedPackage.value = "S1 Package";
//   }

// // SETTING PACKAGE 2
//   void setPackage2() {
//     waitingRate = 0.01583;
//     movingRate = 2.73;
//     packageCost = 4.92;
//     isPackage2 = true;
//     selectedPackage.value = "S2 Package";
//   }

// // SETTING PACKAGE 3
//   void setPackage3() {
//     waitingRate = 0.01583;
//     movingRate = 2.73;
//     packageCost = 7.42;
//     isPackage3 = true;
//     selectedPackage.value = "S3 Package";
//   }
// }

// // Future<void> onResumeTracking() async {
// //   if (!(await _checkLocationPermission())) {
// //     await _requestLocationPermission();
// //   }

// //   if (await _checkLocationPermission()) {
// //     isTracking = true;
// //     isMoving = false;
// //     isTunnel = false;
// //     speed = 0.0;
// //     // lastPosition = await Geolocator.getCurrentPosition();
// //     lastPosition = null;
// //     tunnelEndPosition = await Geolocator.getCurrentPosition();
// //     tunnelEndTime = DateTime.now().toString();
// //     calculateTunnelFare();
// //     update();

// //     positionStreamSubscription = Geolocator.getPositionStream(
// //       locationSettings: const LocationSettings(
// //         accuracy: LocationAccuracy.high,
// //         distanceFilter: 1,
// //       ),
// //     ).listen((Position position) {
// //       final currentSpeed = position.speed * 3.6;

// //       if (lastPosition == null) {
// //         tunnelTime += 1;
// //         update();
// //       }
// //       if (lastPosition != null) {
// //         final distance = vincentyDistance(
// //           lastPosition!.latitude,
// //           lastPosition!.longitude,
// //           position.latitude,
// //           position.longitude,
// //         );

// //         if (currentSpeed >= 1) {
// //           // isMoving = true;
// //           // movingTime += 1;
// //           totalDistance += distance / 1000;
// //         } else if (currentSpeed < 1) {
// //           // isMoving = false;
// //           // waitingTime += 1;
// //           // totalDistance += (distance - 0.001) / 1000;
// //         }
// //         // calculateFare();
// //         speed = currentSpeed;
// //         update();
// //       }

// //       lastPosition = position;
// //     });

// //     updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
// //       if (isTracking) {
// //         if (speed < 25) {
// //           isMoving = false;
// //           waitingTime += 1;
// //         } else if (speed >= 25) {
// //           isMoving = true;
// //           movingTime += 1;
// //         }
// //         calculateFare();
// //         update();
// //       }
// //     });
// //   } else {
// //     if (kDebugMode) {
// //       print('Location permission not granted');
// //     }
// //   }
// // }

// // Future<void> onPauseTracking() async {
// //   isTracking = false;
// //   isTunnel = true;
// //   // endTime = DateTime.now().toString();
// //   positionStreamSubscription?.cancel();
// //   updateTimer?.cancel();
// //   tunnelDistance = 0.0;
// //   tunnelFare = 0.0;
// //   tunnelEndPosition = null;
// //   tunnelStartPosition = await Geolocator.getCurrentPosition();
// //   tunnelStartTime = DateTime.now().toString();
// //   tunnelEndTime = '';
// //   update();
// // }

// // void calculateTunnelFare() {
// //   final tunDistance = Geolocator.distanceBetween(
// //       tunnelStartPosition!.latitude,
// //       tunnelStartPosition!.longitude,
// //       tunnelEndPosition!.latitude,
// //       tunnelEndPosition!.longitude);
// //   if (tunnelStartTime.isEmpty || tunnelEndTime.isEmpty) {
// //     return;
// //   }
// //   final DateTime tstartTime = DateTime.parse(tunnelStartTime);
// //   final DateTime tendTime = DateTime.parse(tunnelEndTime);
// //   final Duration tduration = tendTime.difference(tstartTime);
// //   tunnelTime = tduration.inSeconds.toDouble();

// //   tunnelDistance = tunDistance / 1000;
// //   double tunspeed = (tunDistance / tunnelTime) * 3.6;

// //   if (tunspeed > 25) {
// //     tunnelFare = tunnelDistance * movingRate;
// //   } else if (tunspeed <= 25) {
// //     tunnelFare = tunnelTime * waitingRate;
// //   }
// //   totalDistance += tunnelDistance;
// //   totalTunnelFare += tunnelFare;
// //   totalFare += totalTunnelFare;
// //   update();
// // }
