import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/views/ride_view.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});

  RideController rideController = Get.put(RideController());

  // Method to show the dialog box
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a Package'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: const Text('S1 Package'),
                  onTap: () {
                    rideController.setPackage1();
                    Get.off(() => RideView());
                  },
                ),
                ListTile(
                  title: const Text('S2 Package'),
                  onTap: () {
                    rideController.setPackage2();
                    // Get.off(() => const RideView());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RideView()));
                  },
                ),
                ListTile(
                  title: const Text('S3 Package'),
                  onTap: () {
                    rideController.setPackage3();
                    Get.off(() => RideView());
                  },
                ),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/driverimge.jpeg'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Driver name: John Wick"),
                    Text("Driver ID: 12589"),
                    Text("Vehicle number: 12589"),
                    Text("Meter ID: 12589"),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: const Center(
              child: Text(
                '\$30.30',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showDialog(context);
                  // Get.to(() => const RideView());
                },
                child: const Text('Go'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('History'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
