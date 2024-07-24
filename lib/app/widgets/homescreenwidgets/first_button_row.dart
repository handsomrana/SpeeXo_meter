import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/local_database/isar_services.dart';
import 'package:speed_meter_app/app/views/history_view.dart';
import 'package:speed_meter_app/utils/styles.dart';

class HomeScreenFirstButtonRow extends StatelessWidget {
  const HomeScreenFirstButtonRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: elevatedButtonStyle.copyWith(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Icon(
                        Icons.message,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Messages",
                        style: elevatdButtonTextstyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                final isarServices = IsarServices();
                await isarServices.getRides();
                Get.to(() => const HistoryView());
              },
              style: elevatedButtonStyle.copyWith(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Icon(
                        Icons.history,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "History",
                        style: elevatdButtonTextstyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
