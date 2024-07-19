import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});

  RideController rideController = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeeXo Drive'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
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
        ],
      ),
    );
  }
}
