import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_meter_app/app/data/history_data.dart';
import 'package:speed_meter_app/app/widgets/history_item_card.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 67, 69, 118),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(48, 49, 85, 1),
          title: Text(
            "History",
            style: GoogleFonts.kalam(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: rideCollectionsData.isNotEmpty
            ? ListView.builder(
                itemCount: rideCollectionsData.length,
                itemBuilder: (context, index) {
                  return RideCollectionCard(ride: rideCollectionsData[index]);
                },
              )
            : Center(
                child: Text(
                  "No History",
                  style: GoogleFonts.blackOpsOne(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ));
  }
}
