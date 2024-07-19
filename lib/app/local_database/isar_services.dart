import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_meter_app/app/data/history_data.dart';
import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';

class IsarServices {
  static final IsarServices _instance = IsarServices._internal();
  late Future<Isar> db;

  factory IsarServices() {
    return _instance;
  }

  IsarServices._internal() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    if (Isar.instanceNames.isNotEmpty) {
      // Return the already opened instance
      return Future.value(Isar.getInstance());
    }

    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [RideCollectionSchema],
      directory: dir.path,
    );
  }

  Future<void> addRide(RideCollection ride) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.rideCollections.put(ride);
    });
  }

  Future<List<RideCollection>> getRides() async {
    final isar = await db;
    final loadedRides = await isar.rideCollections.where().findAll();
    rideCollectionsData = loadedRides;
    return loadedRides;
  }

  Future<void> updateRide(RideCollection ride) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.rideCollections.put(ride);
    });
  }

  Future<void> deleteRide(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.rideCollections.delete(id);
    });
  }
}
