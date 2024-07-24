import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';

class RideCollectionCard extends StatelessWidget {
  final RideCollection ride;

  const RideCollectionCard({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(176, 185, 229, 1),
            Color.fromRGBO(206, 210, 233, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Driver ID: ${ride.driverId}',
              style: GoogleFonts.blackOpsOne(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Package Type: ${ride.packageType}',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Start Location: ${ride.startLocation}',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'End Location: ${ride.endLocation}',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Fare: ${ride.fare} \$',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Distance: ${ride.distance} Km',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Duration: ${ride.duration}',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Start Time: ${ride.startTime}',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'End Time: ${ride.endTime}',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Tolls: ${ride.tolls} \$',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Extra: ${ride.extra} \$',
              style: GoogleFonts.sairaCondensed(
                color: const Color.fromRGBO(56, 58, 105, 1),
              ),
            ),
            Text(
              'Status: ${ride.status}',
              style: GoogleFonts.sairaCondensed(
                  color: const Color.fromRGBO(56, 58, 105, 1),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
