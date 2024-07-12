import 'package:flutter/material.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/widgets/custom_card.dart';

class PackageAlertDialogWidget extends StatelessWidget {
  const PackageAlertDialogWidget({
    super.key,
    required this.rideController,
    required this.direction,
  });

  final RideController rideController;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a Package'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          scrollDirection: direction,
          shrinkWrap: true,
          children: <Widget>[
            CustomCard(
                heading: "S1 Package",
                startRate: "4.92",
                pricePerKm: "2.29",
                waitingTime: "0.95",
                onTap: () {
                  rideController.setPackage1();
                  Navigator.pop(context);
                }),
            CustomCard(
                heading: "S2 Package",
                startRate: "4.92",
                pricePerKm: "2.73",
                waitingTime: "0.95",
                onTap: () {
                  rideController.setPackage2();
                  Navigator.pop(context);
                }),
            CustomCard(
                heading: "S3 Package",
                startRate: "7.42",
                pricePerKm: "2.73",
                waitingTime: "0.95",
                onTap: () {
                  rideController.setPackage3();
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
