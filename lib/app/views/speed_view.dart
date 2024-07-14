// // import 'package:flutter/material.dart';
// // import 'package:flutter_background_service/flutter_background_service.dart';
// // import 'package:flutter_overlay_window/flutter_overlay_window.dart';

// // class BackGroundScreen extends StatefulWidget {
// //   const BackGroundScreen({super.key});

// //   @override
// //   State<BackGroundScreen> createState() => _BackGroundScreenState();
// // }

// // class _BackGroundScreenState extends State<BackGroundScreen> {
// //   void permissionstaking() async {
// //     if (await FlutterOverlayWindow.isPermissionGranted() == false) {
// //       FlutterOverlayWindow.requestPermission();
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: () {
// //                 // FlutterBackgroundService().invoke('setAsForeground');
// //               },
// //               child: const Text("foreground"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // FlutterBackgroundService().invoke('setAsBackground');
// //               },
// //               child: const Text("background"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 // final sevic = FlutterBackgroundService();
// //                 // bool isrunning = await sevic.isRunning();
// //                 // if (isrunning) {
// //                 //   sevic.invoke('stopService');
// //                 // } else {
// //                 //   sevic.startService();
// //                 // }
// //               },
// //               child: const Text("start/stop"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 // await FlutterOverlayWindow.showOverlay();
// //                 permissionstaking();
// //                 FlutterOverlayWindow.showOverlay(overlayTitle: 'hello');
// //               },
// //               child: const Text("Show overlay"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 await FlutterOverlayWindow.closeOverlay();
// //               },
// //               child: const Text("Close oberlay"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// // import 'package:speed_meter_app/app/controllers/speed_controller.dart';

// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   FlutterOverlayWindow.isActive();
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       home: HomeScreen(),
// //     );
// //   }
// // }

// // class HomeScreen extends StatelessWidget {
// //   final OverlayController overlayController = Get.put(OverlayController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('GetX with Overlay Example')),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             ElevatedButton(
// //               onPressed: () async {
// //                 if (await FlutterOverlayWindow.isActive()) return;
// //                 await FlutterOverlayWindow.showOverlay(
// //                   enableDrag: true,
// //                   overlayTitle: "X-SLAYER",
// //                   overlayContent: 'Overlay Enabled',
// //                   flag: OverlayFlag.defaultFlag,
// //                   visibility: NotificationVisibility.visibilityPublic,
// //                   positionGravity: PositionGravity.left,
// //                   height: (MediaQuery.of(context).size.height * 0.6).toInt(),
// //                   width: WindowSize.matchParent,
// //                   startPosition: const OverlayPosition(0, -10),
// //                 );
// //               },
// //               child: Text('Show Overlay Text'),
// //             ),
// //             TextButton(
// //               onPressed: () async {
// //                 await FlutterOverlayWindow.resizeOverlay(
// //                   WindowSize.matchParent,
// //                   (MediaQuery.of(context).size.height * 5).toInt(),
// //                   false,
// //                 );
// //               },
// //               child: const Text("Update Overlay"),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 overlayController.hideOverlay();
// //               },
// //               child: Text('Hide Overlay Text'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:developer';
// import 'dart:isolate';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';

// class TrueCallerOverlay extends StatefulWidget {
//   const TrueCallerOverlay({Key? key}) : super(key: key);

//   @override
//   State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
// }

// class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
//   bool isGold = true;

//   final _goldColors = const [
//     Color(0xFFa2790d),
//     Color(0xFFebd197),
//     Color(0xFFa2790d),
//   ];

//   final _silverColors = const [
//     Color(0xFFAEB2B8),
//     Color(0xFFC7C9CB),
//     Color(0xFFD7D7D8),
//     Color(0xFFAEB2B8),
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: isGold ? _goldColors : _silverColors,
//             ),
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 isGold = !isGold;
//               });
//               FlutterOverlayWindow.getOverlayPosition().then((value) {
//                 log("Overlay Position: $value");
//               });
//             },
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     ListTile(
//                       leading: Container(
//                         height: 80.0,
//                         width: 80.0,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black54),
//                           shape: BoxShape.circle,
//                           image: const DecorationImage(
//                             image: NetworkImage(
//                                 "https://api.multiavatar.com/x-slayer.png"),
//                           ),
//                         ),
//                       ),
//                       title: const Text(
//                         "X-SLAYER",
//                         style: TextStyle(
//                             fontSize: 20.0, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: const Text("Sousse , Tunisia"),
//                     ),
//                     const Spacer(),
//                     const Divider(color: Colors.black54),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("+216 21065826"),
//                               Text("Last call - 1 min ago"),
//                             ],
//                           ),
//                           Text(
//                             "Flutter Overlay",
//                             style: TextStyle(
//                                 fontSize: 15.0, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: IconButton(
//                     onPressed: () async {
//                       await FlutterOverlayWindow.closeOverlay();
//                     },
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   static const String _kPortNameOverlay = 'OVERLAY';
//   static const String _kPortNameHome = 'UI';
//   final _receivePort = ReceivePort();
//   SendPort? homePort;
//   String? latestMessageFromOverlay;

//   @override
//   void initState() {
//     super.initState();
//     if (homePort != null) return;
//     final res = IsolateNameServer.registerPortWithName(
//       _receivePort.sendPort,
//       _kPortNameHome,
//     );
//     log("$res: OVERLAY");
//     _receivePort.listen((message) {
//       log("message from OVERLAY: $message");
//       setState(() {
//         latestMessageFromOverlay = 'Latest Message From Overlay: $message';
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             TextButton(
//               onPressed: () async {
//                 final status = await FlutterOverlayWindow.isPermissionGranted();
//                 log("Is Permission Granted: $status");
//               },
//               child: const Text("Check Permission"),
//             ),
//             const SizedBox(height: 10.0),
//             TextButton(
//               onPressed: () async {
//                 final bool? res =
//                     await FlutterOverlayWindow.requestPermission();
//                 log("status: $res");
//               },
//               child: const Text("Request Permission"),
//             ),
//             const SizedBox(height: 10.0),
//             TextButton(
//               onPressed: () async {
//                 if (await FlutterOverlayWindow.isActive()) return;
//                 await FlutterOverlayWindow.showOverlay(
//                   enableDrag: true,
//                   overlayTitle: "X-SLAYER",
//                   overlayContent: 'Overlay Enabled',
//                   flag: OverlayFlag.defaultFlag,
//                   visibility: NotificationVisibility.visibilityPublic,
//                   positionGravity: PositionGravity.auto,
//                   height: (MediaQuery.of(context).size.height * 0.6).toInt(),
//                   width: WindowSize.matchParent,
//                   startPosition: const OverlayPosition(0, -259),
//                 );
//               },
//               child: const Text("Show Overlay"),
//             ),
//             const SizedBox(height: 10.0),
//             TextButton(
//               onPressed: () async {
//                 final status = await FlutterOverlayWindow.isActive();
//                 log("Is Active?: $status");
//               },
//               child: const Text("Is Active?"),
//             ),
//             const SizedBox(height: 10.0),
//             TextButton(
//               onPressed: () async {
//                 await FlutterOverlayWindow.resizeOverlay(
//                   WindowSize.matchParent,
//                   (MediaQuery.of(context).size.height * 5).toInt(),
//                   false,
//                 );
//               },
//               child: const Text("Update Overlay"),
//             ),
//             const SizedBox(height: 10.0),
//             TextButton(
//               onPressed: () {
//                 log('Try to close');
//                 FlutterOverlayWindow.closeOverlay()
//                     .then((value) => log('STOPPED: alue: $value'));
//               },
//               child: const Text("Close Overlay"),
//             ),
//             const SizedBox(height: 20.0),
//             TextButton(
//               onPressed: () {
//                 homePort ??=
//                     IsolateNameServer.lookupPortByName(_kPortNameOverlay);
//                 homePort?.send('Send to overlay: ${DateTime.now()}');
//               },
//               child: const Text("Send message to overlay"),
//             ),
//             const SizedBox(height: 20.0),
//             TextButton(
//               onPressed: () {
//                 FlutterOverlayWindow.getOverlayPosition().then((value) {
//                   log('Overlay Position: $value');
//                   setState(() {
//                     latestMessageFromOverlay = 'Overlay Position: $value';
//                   });
//                 });
//               },
//               child: const Text("Get overlay position"),
//             ),
//             const SizedBox(height: 20.0),
//             TextButton(
//               onPressed: () {
//                 FlutterOverlayWindow.moveOverlay(
//                   const OverlayPosition(0, 0),
//                 );
//               },
//               child: const Text("Move overlay position to (0, 0)"),
//             ),
//             const SizedBox(height: 20),
//             Text(latestMessageFromOverlay ?? ''),
//           ],
//         ),
//       ),
//     );
//   }
// }
