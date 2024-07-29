import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MzRideController extends GetxController {
  var speedGeolocator = 0.0.obs; // Speed in km/h from Geolocator
  var totalDistanceGeolocator = 0.0.obs; // Distance in km from Geolocator
  var fareGeolocator = 4.92.obs; // Starting fare for Geolocator
  var waitingTimeGeolocator = 0.0.obs; // Waiting time in minutes for Geolocator

  var speedGoogleAPI = 0.0.obs; // Speed in km/h from Google API
  var totalDistanceGoogleAPI = 0.0.obs; // Distance in km from Google API
  var fareGoogleAPI = 4.92.obs; // Starting fare for Google API
  var waitingTimeGoogleAPI = 0.0.obs; // Waiting time in minutes for Google API

  Position? lastPositionGeolocator;
  LatLng? lastPositionGoogleAPI;
  Timer? timer;
  DateTime? lostTimeGeolocator;
  DateTime? lostTimeGoogleAPI;
  double? lastSpeedGeolocator;
  double? lastSpeedGoogleAPI;

  var isRideActive = false.obs; // To track if the ride is active


  void startRide() {
    if (!isRideActive.value) {
      isRideActive.value = true;
      _initGeolocator();
      _initGoogleAPI();
    }
  }

  void stopRide() {
    if (isRideActive.value) {
      isRideActive.value = false;
      timer?.cancel();
      // Optionally, finalize calculations or reset values
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void _initGeolocator() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high))
        .listen((Position position) {
      if (lastPositionGeolocator != null) {
        final distanceInMeters = Geolocator.distanceBetween(
            lastPositionGeolocator!.latitude,
            lastPositionGeolocator!.longitude,
            position.latitude,
            position.longitude);
        final distanceInKm = distanceInMeters / 1000;
        totalDistanceGeolocator.value += distanceInKm;
        _calculateFareGeolocator(distanceInKm);
      }
      lastPositionGeolocator = position;
      lastSpeedGeolocator = position.speed * 3.6; // Convert m/s to km/h
      speedGeolocator.value = lastSpeedGeolocator!;
      if (lostTimeGeolocator != null) {
        _onLocationRegainedGeolocator(position);
      }
    }, onDone: _onLocationLostGeolocator, onError: (error) {
      print("Error: $error");
      _onLocationLostGeolocator();
    });
  }

  void _initGoogleAPI() async {
    // Simulating location update from Google API periodically
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _simulateGoogleAPILocationUpdate());
  }

  void _simulateGoogleAPILocationUpdate() {
    if (!isRideActive.value) return; // Only update if ride is active

    // Simulate movement with slight variation
    LatLng newPosition = LatLng(
      lastPositionGoogleAPI?.latitude ?? 37.7749 + (0.0001 * (1 - 2 * (DateTime.now().millisecondsSinceEpoch % 2))),
      lastPositionGoogleAPI?.longitude ?? -122.4194 + (0.0001 * (1 - 2 * (DateTime.now().millisecondsSinceEpoch % 2))),
    );

    double simulatedSpeed = lastSpeedGoogleAPI ?? 30.0 + (5.0 * (1 - 2 * (DateTime.now().millisecondsSinceEpoch % 2))); // Simulated speed

    if (lastPositionGoogleAPI != null) {
      final distanceInMeters = Geolocator.distanceBetween(
          lastPositionGoogleAPI!.latitude,
          lastPositionGoogleAPI!.longitude,
          newPosition.latitude,
          newPosition.longitude);
      final distanceInKm = distanceInMeters / 1000;
      totalDistanceGoogleAPI.value += distanceInKm;
      _calculateFareGoogleAPI(distanceInKm);
    }

    lastPositionGoogleAPI = newPosition;
    lastSpeedGoogleAPI = simulatedSpeed;
    speedGoogleAPI.value = simulatedSpeed;
    if (lostTimeGoogleAPI != null) {
      _onLocationRegainedGoogleAPI(newPosition);
    }
  }

  void _calculateFareGeolocator(double distanceInKm) {
    if (speedGeolocator.value > 25) {
      fareGeolocator.value += 2.29 * distanceInKm;
    } else {
      waitingTimeGeolocator.value += 1.0 / 60.0; // Assuming this method is called every second
      fareGeolocator.value += 0.95 / 60.0; // Add waiting fare per minute
    }
  }

  void _calculateFareGoogleAPI(double distanceInKm) {
    if (speedGoogleAPI.value > 25) {
      fareGoogleAPI.value += 2.29 * distanceInKm;
    } else {
      waitingTimeGoogleAPI.value += 1.0 / 60.0; // Assuming this method is called every second
      fareGoogleAPI.value += 0.95 / 60.0; // Add waiting fare per minute
    }
  }

  void _onLocationLostGeolocator() {
    lostTimeGeolocator = DateTime.now();
  }

  void _onLocationLostGoogleAPI() {
    lostTimeGoogleAPI = DateTime.now();
  }

  void _onLocationRegainedGeolocator(Position newPosition) {
    if (lostTimeGeolocator != null) {
      final regainedTime = DateTime.now();
      final elapsedTime = regainedTime.difference(lostTimeGeolocator!).inSeconds;

      final averageSpeed = (lastSpeedGeolocator! + newPosition.speed * 3.6) / 2; // m/s to km/h
      final estimatedDistance = averageSpeed * (elapsedTime / 3600); // Convert seconds to hours

      totalDistanceGeolocator.value += estimatedDistance;
      _calculateFareGeolocator(estimatedDistance);
      lostTimeGeolocator = null; // Reset the lostTime after calculation
    }
    lastPositionGeolocator = newPosition;
    speedGeolocator.value = newPosition.speed * 3.6; // Convert m/s to km/h
  }

  void _onLocationRegainedGoogleAPI(LatLng newPosition) {
    if (lostTimeGoogleAPI != null) {
      final regainedTime = DateTime.now();
      final elapsedTime = regainedTime.difference(lostTimeGoogleAPI!).inSeconds;

      final averageSpeed = lastSpeedGoogleAPI ?? 30.0; // Assuming the speed is updated periodically
      final estimatedDistance = averageSpeed * (elapsedTime / 3600); // Convert seconds to hours

      totalDistanceGoogleAPI.value += estimatedDistance;
      _calculateFareGoogleAPI(estimatedDistance);
      lostTimeGoogleAPI = null; // Reset the lostTime after calculation
    }
    lastPositionGoogleAPI = newPosition;
    speedGoogleAPI.value = lastSpeedGoogleAPI ?? 30.0; // Use last known speed if available
  }
}
