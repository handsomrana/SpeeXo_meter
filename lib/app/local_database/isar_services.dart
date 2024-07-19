import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';

class IsarServices {
  late Future<Isar> isardb;
  RideController rideController = Get.put(RideController());
  RideCollection? readedCollections;

  IsarServices() {
    isardb = _initIsar();
  }

  Isar isar = IsarServices().isar;

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();

    return await Isar.open(
      [RideCollectionSchema],
      directory: dir.path,
    );
  }

  Future<void> storeRideCollection() async {
    final rides = isar.rideCollections;
    final newride = RideCollection(
        userId: '001',
        distance: rideController.totalDistance.toStringAsFixed(1),
        fare: rideController.totalFare.toStringAsFixed(1),
        packageType: 'S1',
        status: "Completed",
        tolls: rideController.tollsAmount.toStringAsFixed(1),
        startTime: rideController.startTime.toString(),
        endTime: rideController.endTime.toString(),
        startLocation: rideController.startPosition.toString(),
        endLocation: rideController.lastPosition.toString(),
        duration: rideController.endTime);

    await isar.writeTxn(() async {
      await rides.put(newride);
    });
  }

  Future<void> readRideCollection() async {
    final getRides = isar.rideCollections;
    final getRCollections = await getRides.where().findAll();
    readedCollections = getRCollections.first;
  }
}
