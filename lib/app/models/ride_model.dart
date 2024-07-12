class RideModel {
  String package;

  RideModel({
    required this.package,
  });
  RideModel.addPackage(String packge) : package = packge;

  Map<String, dynamic> toJson() {
    return {
      'package': package,
    };
  }
}
