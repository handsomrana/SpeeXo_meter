import 'package:flutter/material.dart';
import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';

class RideCollectionCard extends StatelessWidget {
  final RideCollection ride;

  const RideCollectionCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User ID: ${ride.userId}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Package Type: ${ride.packageType}'),
            Text('Start Location: ${ride.startLocation}'),
            Text('End Location: ${ride.endLocation}'),
            Text('Fare: ${ride.fare}'),
            Text('Distance: ${ride.distance}'),
            Text('Duration: ${ride.duration}'),
            Text('Start Time: ${ride.startTime}'),
            Text('End Time: ${ride.endTime}'),
            Text('Tolls: ${ride.tolls}'),
            Text('Status: ${ride.status}'),
          ],
        ),
      ),
    );
  }
}
