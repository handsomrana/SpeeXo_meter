// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';

// class BackGroundScreen extends StatefulWidget {
//   const BackGroundScreen({super.key});

//   @override
//   State<BackGroundScreen> createState() => _BackGroundScreenState();
// }

// class _BackGroundScreenState extends State<BackGroundScreen> {
//   void permissionstaking() async {
//     if (await FlutterOverlayWindow.isPermissionGranted() == false) {
//       FlutterOverlayWindow.requestPermission();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // FlutterBackgroundService().invoke('setAsForeground');
//               },
//               child: const Text("foreground"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // FlutterBackgroundService().invoke('setAsBackground');
//               },
//               child: const Text("background"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // final sevic = FlutterBackgroundService();
//                 // bool isrunning = await sevic.isRunning();
//                 // if (isrunning) {
//                 //   sevic.invoke('stopService');
//                 // } else {
//                 //   sevic.startService();
//                 // }
//               },
//               child: const Text("start/stop"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // await FlutterOverlayWindow.showOverlay();
//                 permissionstaking();
//                 FlutterOverlayWindow.showOverlay(overlayTitle: 'hello');
//               },
//               child: const Text("Show overlay"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await FlutterOverlayWindow.closeOverlay();
//               },
//               child: const Text("Close oberlay"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:speed_meter_app/app/controllers/speed_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterOverlayWindow.isActive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final OverlayController overlayController = Get.put(OverlayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX with Overlay Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                if (await FlutterOverlayWindow.isActive()) return;
                await FlutterOverlayWindow.showOverlay(
                  enableDrag: true,
                  overlayTitle: "X-SLAYER",
                  overlayContent: 'Overlay Enabled',
                  flag: OverlayFlag.defaultFlag,
                  visibility: NotificationVisibility.visibilityPublic,
                  positionGravity: PositionGravity.left,
                  height: (MediaQuery.of(context).size.height * 0.6).toInt(),
                  width: WindowSize.matchParent,
                  startPosition: const OverlayPosition(0, -10),
                );
              },
              child: Text('Show Overlay Text'),
            ),
            TextButton(
              onPressed: () async {
                await FlutterOverlayWindow.resizeOverlay(
                  WindowSize.matchParent,
                  (MediaQuery.of(context).size.height * 5).toInt(),
                  false,
                );
              },
              child: const Text("Update Overlay"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                overlayController.hideOverlay();
              },
              child: Text('Hide Overlay Text'),
            ),
          ],
        ),
      ),
    );
  }
}
