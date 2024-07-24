import 'package:isar/isar.dart';
part 'ride_collection.g.dart';

@Collection()
class RideCollection {
  RideCollection(
      {required this.driverId,
      required this.packageType,
      required this.startLocation,
      required this.endLocation,
      required this.fare,
      required this.distance,
      required this.duration,
      required this.startTime,
      required this.endTime,
      required this.tolls,
      required this.extra,
      required this.status});

  final Id rideId = Isar.autoIncrement;
  final String driverId;
  final String packageType;
  final String fare;
  final String distance;
  final String duration;
  final String startLocation;
  final String endLocation;
  final String startTime;
  final String endTime;
  final String tolls;
  final String extra;
  final String status;
}
