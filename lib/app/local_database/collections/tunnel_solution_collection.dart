import 'package:isar/isar.dart';
part 'tunnel_solution_collection.g.dart';

@Collection()
class TunnelSolutionCollection {
  TunnelSolutionCollection({
    required this.positionLatitude,
    required this.positionLongitude,
    required this.timeStamp,
  });

  final Id tSolutionId = Isar.autoIncrement;
  late double positionLatitude;
  late double positionLongitude;
  late DateTime timeStamp;
}
