import 'package:flutter/material.dart';
import 'package:speed_meter_app/app/data/history_data.dart';
import 'package:speed_meter_app/app/widgets/history_item_card.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
        ),
        body: rideCollectionsData.isNotEmpty
            ? ListView.builder(
                itemCount: rideCollectionsData.length,
                itemBuilder: (context, index) {
                  return RideCollectionCard(ride: rideCollectionsData[index]);
                },
              )
            : const Center(
                child: Text("No History"),
              ));
  }
}
