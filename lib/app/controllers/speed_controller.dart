import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class OverlayController extends GetxController {
  Future<void> requestPermission() async {
    if (!await FlutterOverlayWindow.isPermissionGranted()) {
      await FlutterOverlayWindow.requestPermission();
    }
  }

  void showOverlay() async {
    await requestPermission();

    // Define the `Text` widget you want to display
    final overlayText = Center(
      child: Material(
        color: Colors.transparent,
        child: Text(
          'Hello, I am an overlay!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );

    // Show the `Text` widget as an overlay
    FlutterOverlayWindow.showOverlay(
      overlayTitle: 'Overlay Title',
      // overlayText: overlayText,
      positionGravity: PositionGravity.left, // Position of the overlay text
      width: 300, // Width of the overlay text box
      height: 100, // Height of the overlay text box
    );
  }

  void hideOverlay() {
    FlutterOverlayWindow.closeOverlay();
  }
}
