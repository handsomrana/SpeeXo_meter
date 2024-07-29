import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';
import 'package:speed_meter_app/app/local_database/collections/tunnel_solution_collection.dart';
import 'package:speed_meter_app/app/local_database/isar_services.dart';
import 'dart:async';
import 'package:speed_meter_app/utils/vacent_disatance.dart';
import 'package:location/location.dart' as loc;

class RideController extends GetxController {
  final IsarServices isarServices = IsarServices();
  loc.Location location = loc.Location();
  double packageCost = 4.92;
  double movingRate = 2.29;
  double waitingRate = 0.01583;
  var selectedPackage = 'DEFAULT'.obs;
  double extraAmount = 0.0;
  double tollsAmount = 0.0;
  // Position? tunnelTestingPosition;
  double totalFare = 0.0;
  double movingFare = 0.0;
  double waitingFare = 0.0;
  bool isTracking = false;
  bool isMoving = false;
  bool isPackage1 = false;
  bool isPackage2 = false;
  bool isPackage3 = false;
  String startAddress = '';
  String endAddress = '';
  double totalDistance = 0.0;
  double speed = 0.0;
  String startTime = '';
  String endTime = '';
  Position? lastPosition;
  Position? startPosition;
  double totalLocalDistance = 0.0;
  double totalStraightDistance = 0.0;
  double totalStraightFare = 0.0;
  double totalLocalFare = 0.0;
  double localMovingFare = 0.0;
  double straightMovingFare = 0.0;
  Position? geolocatorTestPosition;
  loc.LocationData? locationTestPosition;
  final positions = <TunnelSolutionCollection>[].obs;
  // Position? tunnelEndPosition;
  // double tunnelDistance = 0.0;
  // double tunnelFare = 0.0;
  // double totalTunnelFare = 0.0;
  // double tunnelTime = 0.0;
  // String tunnelStartTime = '';
  // String tunnelEndTime = '';
  // bool isTunnel = false;

  StreamSubscription<Position>? positionStreamSubscription;
  Timer? updateTimer;
  int waitingTime = 0; // Store waiting time in seconds
  int movingTime = 0;

  Future<void> startTracking() async {
    if (!(await _checkLocationPermission())) {
      await _requestLocationPermission();
    }

    if (await _checkLocationPermission()) {
      isTracking = true;
      isMoving = false;
      startTime = DateTime.now().toString();
      endTime = '';
      totalDistance = 0.0;
      speed = 0.0;
      extraAmount = 0.0;
      tollsAmount = 0.0;
      startPosition = await Geolocator.getCurrentPosition();
      lastPosition = null;
      await savePositionToLocal();
      waitingTime = 0;
      movingTime = 0;
      totalFare = 0.0;
      movingFare = 0.0;
      waitingFare = 0.0;
      totalLocalDistance = 0.0;
      totalStraightDistance = 0.0;
      totalLocalFare = 0.0;
      localMovingFare = 0.0;
      straightMovingFare = 0.0;
      totalStraightFare = 0.0;
      locationTestPosition = await location.getLocation();
      geolocatorTestPosition = await Geolocator.getCurrentPosition();
      // tunnelTime = 0.0;
      // tunnelDistance = 0.0;
      // tunnelFare = 0.0;
      // totalTunnelFare = 0.0;
      // tunnelStartTime = '';
      // tunnelEndTime = '';
      // isTunnel = false;
      update();

      positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1,
        ),
      ).listen((Position position) async {
        final currentSpeed = position.speed * 3.6;

        if (lastPosition != null) {
          final distance = vincentyDistance(
            lastPosition!.latitude,
            lastPosition!.longitude,
            position.latitude,
            position.longitude,
          );

          if (currentSpeed >= 1) {
            // isMoving = true;
            // movingTime += 1;
            totalDistance += distance / 1000;
          } else if (currentSpeed < 1) {
            // isMoving = false;
            // waitingTime += 1;
            // totalDistance += (distance - 0.001) / 1000;
          }
          // calculateFare();
          speed = currentSpeed;
          update();
        }
        // lastPosition = await Geolocator.getLastKnownPosition();
        lastPosition = position;
      });

      updateTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          await savePositionToLocal();
          locationTestPosition = await location.getLocation();
          final tloc = await Geolocator.getCurrentPosition();
          geolocatorTestPosition = tloc;
          if (!tloc.isMocked) {
            positions.add(TunnelSolutionCollection(
              positionLatitude: tloc.latitude,
              positionLongitude: tloc.longitude,
              timeStamp: DateTime.now(),
            ));
          }

          if (isTracking) {
            if (speed < 25) {
              isMoving = false;
              waitingTime += 1;
            } else if (speed >= 25) {
              isMoving = true;
              movingTime += 1;
            }

            calculateFare();
            update();
          }
        },
      );
    } else {
      if (kDebugMode) {
        print('Location permission not granted');
      }
    }
  }

  // Future<void> onResumeTracking() async {
  //   if (!(await _checkLocationPermission())) {
  //     await _requestLocationPermission();
  //   }

  //   if (await _checkLocationPermission()) {
  //     isTracking = true;
  //     isMoving = false;
  //     isTunnel = false;
  //     speed = 0.0;
  //     // lastPosition = await Geolocator.getCurrentPosition();
  //     lastPosition = null;
  //     tunnelEndPosition = await Geolocator.getCurrentPosition();
  //     tunnelEndTime = DateTime.now().toString();
  //     calculateTunnelFare();
  //     update();

  //     positionStreamSubscription = Geolocator.getPositionStream(
  //       locationSettings: const LocationSettings(
  //         accuracy: LocationAccuracy.high,
  //         distanceFilter: 1,
  //       ),
  //     ).listen((Position position) {
  //       final currentSpeed = position.speed * 3.6;

  //       if (lastPosition == null) {
  //         tunnelTime += 1;
  //         update();
  //       }
  //       if (lastPosition != null) {
  //         final distance = vincentyDistance(
  //           lastPosition!.latitude,
  //           lastPosition!.longitude,
  //           position.latitude,
  //           position.longitude,
  //         );

  //         if (currentSpeed >= 1) {
  //           // isMoving = true;
  //           // movingTime += 1;
  //           totalDistance += distance / 1000;
  //         } else if (currentSpeed < 1) {
  //           // isMoving = false;
  //           // waitingTime += 1;
  //           // totalDistance += (distance - 0.001) / 1000;
  //         }
  //         // calculateFare();
  //         speed = currentSpeed;
  //         update();
  //       }

  //       lastPosition = position;
  //     });

  //     updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
  //       if (isTracking) {
  //         if (speed < 25) {
  //           isMoving = false;
  //           waitingTime += 1;
  //         } else if (speed >= 25) {
  //           isMoving = true;
  //           movingTime += 1;
  //         }
  //         calculateFare();
  //         update();
  //       }
  //     });
  //   } else {
  //     if (kDebugMode) {
  //       print('Location permission not granted');
  //     }
  //   }
  // }

  // Future<void> onPauseTracking() async {
  //   isTracking = false;
  //   isTunnel = true;
  //   // endTime = DateTime.now().toString();
  //   positionStreamSubscription?.cancel();
  //   updateTimer?.cancel();
  //   tunnelDistance = 0.0;
  //   tunnelFare = 0.0;
  //   tunnelEndPosition = null;
  //   tunnelStartPosition = await Geolocator.getCurrentPosition();
  //   tunnelStartTime = DateTime.now().toString();
  //   tunnelEndTime = '';
  //   update();
  // }

  // void calculateTunnelFare() {
  //   final tunDistance = Geolocator.distanceBetween(
  //       tunnelStartPosition!.latitude,
  //       tunnelStartPosition!.longitude,
  //       tunnelEndPosition!.latitude,
  //       tunnelEndPosition!.longitude);
  //   if (tunnelStartTime.isEmpty || tunnelEndTime.isEmpty) {
  //     return;
  //   }
  //   final DateTime tstartTime = DateTime.parse(tunnelStartTime);
  //   final DateTime tendTime = DateTime.parse(tunnelEndTime);
  //   final Duration tduration = tendTime.difference(tstartTime);
  //   tunnelTime = tduration.inSeconds.toDouble();

  //   tunnelDistance = tunDistance / 1000;
  //   double tunspeed = (tunDistance / tunnelTime) * 3.6;

  //   if (tunspeed > 25) {
  //     tunnelFare = tunnelDistance * movingRate;
  //   } else if (tunspeed <= 25) {
  //     tunnelFare = tunnelTime * waitingRate;
  //   }
  //   totalDistance += tunnelDistance;
  //   totalTunnelFare += tunnelFare;
  //   totalFare += totalTunnelFare;
  //   update();
  // }

  void stopTracking() async {
    await savePositionToLocal();
    await getDistanceFromLocal();
    await getStraightDistance();
    calculateLocalFare();
    calculateStraightFare();
    positions.value = [];
    // print(totalDistance.toStringAsFixed(4));
    // print(totalLocalDistance.toStringAsFixed(4));
    isTracking = false;
    endTime = DateTime.now().toString();
    await getAddressFromCoordinates();
    await addRidetoLocal();
    positionStreamSubscription?.cancel();
    updateTimer?.cancel();
    await isarServices.getRides();
    await isarServices.deletePositions();
    update();
  }

  @override
  void onClose() {
    positionStreamSubscription?.cancel();
    updateTimer?.cancel();
    isTracking = false;
    isMoving = false;
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    await isarServices.getRides();
  }

  Future<bool> _checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      if (kDebugMode) {
        print('Location permission denied');
      }
    }
  }

  String getFormattedWaitingTime() {
    final int minutes = waitingTime ~/ 60;
    final int seconds = waitingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getFormattedMovingTime() {
    final int minutes = movingTime ~/ 60;
    final int seconds = movingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> addRidetoLocal() async {
    final newRide = RideCollection(
        driverId: '001',
        packageType: isPackage1
            ? "S1"
            : isPackage2
                ? "S2"
                : isPackage3
                    ? "S3"
                    : "DEFAULT",
        startLocation: startAddress,
        endLocation: endAddress,
        fare: totalFare.toStringAsFixed(1),
        distance: totalDistance.toStringAsFixed(1),
        duration: calculateDuration(startTime, endTime),
        startTime: startTime,
        endTime: endTime,
        tolls: tollsAmount.toStringAsFixed(1),
        extra: extraAmount.toStringAsFixed(1),
        status: "COMPLETED");

    await isarServices.addRide(newRide);
  }

  Future<void> savePositionToLocal() async {
    final tempcPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    if (!tempcPosition.isMocked) {}
    final newPosition = TunnelSolutionCollection(
      positionLatitude: tempcPosition.latitude,
      positionLongitude: tempcPosition.longitude,
      timeStamp: DateTime.now(),
    );
    await isarServices.addPosition(newPosition);
  }

  Future<void> getDistanceFromLocal() async {
    final positions = await isarServices.getPositions();
    double temDistance = 0.0;
    if (positions.isNotEmpty) {
      for (int i = 0; i < positions.length - 1; i++) {
        final start = positions[i];
        final end = positions[i + 1];
        if (start.positionLatitude == end.positionLatitude &&
            start.positionLongitude == end.positionLongitude) {
          continue;
        }
        if (start.positionLatitude == 0.0 &&
            start.positionLongitude == 0.0 &&
            end.positionLatitude == 0.0 &&
            end.positionLongitude == 0.0) {
          continue;
        }

        final distance = vincentyDistance(
          start.positionLatitude,
          start.positionLongitude,
          end.positionLatitude,
          end.positionLongitude,
        );
        if (distance > 2) {
          temDistance += distance / 1000;
        }
      }
      totalLocalDistance = temDistance;
      update();
    }
  }

  Future<void> getStraightDistance() async {
    final position = positions;
    double temDistance = 0.0;
    if (position.isNotEmpty) {
      for (int i = 0; i < position.length - 1; i++) {
        final start = position[i];
        final end = position[i + 1];

        final distance = vincentyDistance(
          start.positionLatitude,
          start.positionLongitude,
          end.positionLatitude,
          end.positionLongitude,
        );
        temDistance += distance / 1000;
      }
      totalStraightDistance = temDistance;
      update();
    }
  }

  Future<void> getAddressFromCoordinates() async {
    if (startPosition != null && lastPosition != null) {
      try {
        await setLocaleIdentifier("en");
        final List<Placemark> startPlacemarks = await placemarkFromCoordinates(
          startPosition!.latitude,
          startPosition!.longitude,
        );
        if (startPlacemarks.isNotEmpty) {
          final Placemark startPlacemark = startPlacemarks.first;
          startAddress =
              '${startPlacemark.street}, ${startPlacemark.locality},${startPlacemark.subAdministrativeArea}, ${startPlacemark.administrativeArea}, ${startPlacemark.country}';
        }

        final List<Placemark> endPlacemarks = await placemarkFromCoordinates(
          lastPosition!.latitude,
          lastPosition!.longitude,
        );
        if (endPlacemarks.isNotEmpty) {
          final Placemark endPlacemark = endPlacemarks.first;
          endAddress =
              '${endPlacemark.street}, ${endPlacemark.locality}, ${endPlacemark.administrativeArea}, ${endPlacemark.country}';
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error occurred while getting address: $e');
        }
      }
    }
  }

  void addExtraAmount(double amount) {
    extraAmount = amount;
    update();
  }

  void addTollsAmount(double amount) {
    tollsAmount = amount;
    update();
  }

  void calculateFare() {
    movingFare = totalDistance * movingRate;
    waitingFare = waitingTime * waitingRate;
    totalFare =
        tollsAmount + extraAmount + packageCost + movingFare + waitingFare;
  }

  void calculateLocalFare() {
    localMovingFare = totalLocalDistance * movingRate;
    waitingFare = waitingTime * waitingRate;
    totalLocalFare =
        tollsAmount + extraAmount + packageCost + waitingFare + localMovingFare;
  }

  void calculateStraightFare() {
    straightMovingFare = totalStraightDistance * movingRate;
    waitingFare = waitingTime * waitingRate;
    totalStraightFare = tollsAmount +
        extraAmount +
        packageCost +
        waitingFare +
        straightMovingFare;
  }

  String calculateDuration(String start, String end) {
    if (start.isEmpty || end.isEmpty) return '';
    final DateTime startTime = DateTime.parse(start);
    final DateTime endTime = DateTime.parse(end);
    final Duration duration = endTime.difference(startTime);
    double totalMinutes = duration.inSeconds / 60.0;
    return '${totalMinutes.toStringAsFixed(2)} minute';
  }

  void setPackage1() {
    waitingRate = 0.01583;
    movingRate = 2.29;
    packageCost = 4.92;
    isPackage1 = true;
    selectedPackage.value = "S1 Package";
  }

  void setPackage2() {
    waitingRate = 0.01583;
    movingRate = 2.73;
    packageCost = 4.92;
    isPackage2 = true;
    selectedPackage.value = "S2 Package";
  }

  void setPackage3() {
    waitingRate = 0.01583;
    movingRate = 2.73;
    packageCost = 7.42;
    isPackage3 = true;
    selectedPackage.value = "S3 Package";
  }
}
