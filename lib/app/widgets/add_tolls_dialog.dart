// import 'package:flutter/material.dart';
// import 'package:speed_meter_app/app/controllers/ride_controller.dart';

// class AddTollsDialogWidget extends StatelessWidget {
//   const AddTollsDialogWidget({
//     super.key,
//     required this.rideController,
//   });

//   final RideController rideController;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Select Tolls'),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           children: <Widget>[
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Harbour Bridge",
//                   ),
//                   Text(
//                     "\$4",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Airport Fee",
//                   ),
//                   Text(
//                     "\$5.45",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "EASTERN DISTRIBUTOR",
//                   ),
//                   Text(
//                     "\$9.29",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "WESTCONNEX-M4-MB LINK",
//                   ),
//                   Text(
//                     "\$5.65",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "CROSSCITY TUNNEL",
//                   ),
//                   Text(
//                     "\$6.77",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "LANECOVE TUNNEL",
//                   ),
//                   Text(
//                     "\$3.93",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "M5 SOUTH WEST MOTORWAY",
//                   ),
//                   Text(
//                     "\$5.54",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Divider(color: Colors.black54),
//             ListTile(
//               title: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "WESTCONNEX-M5 EAST",
//                   ),
//                   Text(
//                     "\$7.98",
//                   ),
//                 ],
//               ),
//               trailing: Checkbox(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Total Toll:"),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/add_tolls_controller.dart';

class AddTollsDialogWidget extends StatelessWidget {
  final TollController tollController = Get.put(TollController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Tolls'),
      content: SizedBox(
        width: double.maxFinite,
        child: Obx(() {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: tollController.tolls.length,
            itemBuilder: (context, index) {
              final toll = tollController.tolls[index];
              return Column(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(toll.name),
                        Text("\$${toll.price.toStringAsFixed(2)}"),
                      ],
                    ),
                    trailing: Checkbox(
                      value: toll.isSelected,
                      onChanged: (value) {
                        tollController.toggleTollSelection(index);
                      },
                    ),
                  ),
                  const Divider(color: Colors.black54),
                ],
              );
            },
          );
        }),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                "Total Toll: \$${tollController.totalToll.toStringAsFixed(2)}")),
            ElevatedButton(
              onPressed: () {
                tollController.addTollsAmount();
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ],
    );
  }
}
