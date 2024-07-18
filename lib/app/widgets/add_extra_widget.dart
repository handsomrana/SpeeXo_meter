import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/add_extra_numpad_controller.dart';

class AddExtraWidget extends StatelessWidget {
  const AddExtraWidget({super.key, required this.orientation});

  final bool orientation;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add Extras",
        textAlign: TextAlign.center,
      ),
      content: NumPad(
        isTablet: orientation,
      ),
    );
  }
}

class NumPad extends StatelessWidget {
  final NumPadController controller = Get.put(NumPadController());

  NumPad({super.key, required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return isTablet ? isMobileNumpad() : isTabletNumpad();
  }

  Column isMobileNumpad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Obx(() => Text(
                maxLines: 1,
                overflow: TextOverflow.clip,
                controller.extraAmount.value,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              )),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDialerBtn("1"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("2"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("3"),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDialerBtn("4"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("5"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("6"),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDialerBtn("7"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("8"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("9"),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.clearNumber,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: const CircleBorder(),
                  minimumSize: const Size(60, 60)),
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("0"),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                controller.onConfrm();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: const CircleBorder(),
                  minimumSize: const Size(60, 60)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column isTabletNumpad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Obx(() => Text(
                maxLines: 1,
                overflow: TextOverflow.clip,
                controller.extraAmount.value,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              )),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDialerBtn("1"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("2"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("3"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("4"),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDialerBtn("5"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("6"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("7"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("8"),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.clearNumber,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: const CircleBorder(),
                  minimumSize: const Size(60, 60)),
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("9"),
            const SizedBox(
              width: 10,
            ),
            buildDialerBtn("0"),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                controller.onConfrm();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: const CircleBorder(),
                  minimumSize: const Size(60, 60)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDialerBtn(String digit) {
    return ElevatedButton(
      onPressed: () => controller.addDigit(digit),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade700,
          shape: const CircleBorder(),
          minimumSize: const Size(60, 60)),
      child: Text(
        digit,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
