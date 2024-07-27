import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_meter_app/app/local_database/collections/tunnel_solution_collection.dart';
import 'package:speed_meter_app/utils/vacent_disatance.dart';

class ManualRideController extends GetxController {
  double packageCost = 4.92;
  double movingRate = 2.29;
  double waitingRate = 0.01583;
  final isTracking = false.obs;
  final isMoving = false.obs;
  final isMovingRate = false.obs;
  final positions = <TunnelSolutionCollection>[].obs;
  final markers = <Marker>[].obs;
  final polylines = <Polyline>[].obs;
  final fare = 0.0.obs;
  final totalDistance = 0.0.obs;
  final waitingTime = 0.0.obs;
  final lastPosition = Rxn<LatLng>();
  final currentPosition = Rxn<LatLng>();
  Timer? timer;

  late StreamSubscription<Position> positionStream;

  @override
  void onInit() {
    super.onInit();
    // startTracking();
  }

  void startTracking() async {
    isTracking.value = true;
    isMoving.value = true;
    final tempp = await Geolocator.getCurrentPosition();
    currentPosition.value = LatLng(tempp.latitude, tempp.longitude);
    lastPosition.value = currentPosition.value;
    positions.add(TunnelSolutionCollection(
      positionLatitude: tempp.latitude,
      positionLongitude: tempp.longitude,
      timeStamp: DateTime.now(),
    ));
    markers.add(
      Marker(
        markerId: MarkerId(tempp.toString()),
        position: currentPosition.value!,
      ),
    );
    if (isTracking.value) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        calculateFare();
        positionStream = Geolocator.getPositionStream().listen((Position post) {
          final speed = post.speed;
          if (speed > 2 && speed < 25) {
            isMoving.value = true;
            isMovingRate.value = false;
          } else if (speed > 25) {
            isMoving.value = true;
            isMovingRate.value = true;
          } else if (speed < 25 && speed > 2) {
            isMovingRate.value = false;
            isMoving.value = true;
          } else if (speed < 2) {
            isMoving.value = false;
            isMovingRate.value = false;
          }
        });
        if (isMoving.value) {
          lastPosition.value = currentPosition.value;
          final temp = await Geolocator.getCurrentPosition();
          final newPosition = LatLng(temp.latitude, temp.longitude);
          currentPosition.value = newPosition;
          positions.add(TunnelSolutionCollection(
            positionLatitude: temp.latitude,
            positionLongitude: temp.longitude,
            timeStamp: DateTime.now(),
          ));
          if (positions.length > 1) {
            polylines.add(
              Polyline(
                polylineId: PolylineId(newPosition.toString()),
                points: positions
                    .map((pos) =>
                        LatLng(pos.positionLatitude, pos.positionLongitude))
                    .toList(),
                color: Colors.blue,
                width: 5,
              ),
            );
          }
          final distanceInMeter = vincentyDistance(
            currentPosition.value!.latitude,
            currentPosition.value!.longitude,
            lastPosition.value!.latitude,
            lastPosition.value!.longitude,
          );
          if (distanceInMeter > 1) {
            totalDistance.value += distanceInMeter / 1000;
          }
        } else if (!isMoving.value) {
          waitingTime.value += 1;
        }
      });
    }
  }

  void stopTracking() {
    isTracking.value = false;
    markers.add(
      Marker(
        markerId: MarkerId(currentPosition.toString()),
        position: currentPosition.value!,
      ),
    );
    timer!.cancel();
    positionStream.cancel();
  }

  void calculateFare() {
    final distance = vincentyDistance(
        positions.first.positionLatitude,
        positions.first.positionLongitude,
        positions.last.positionLatitude,
        positions.last.positionLongitude);

    fare.value = packageCost +
        (waitingTime.value * waitingRate) +
        (distance / 1000 * movingRate);
  }

  @override
  void onClose() {
    // positionStream.cancel();
    super.onClose();
  }
}
