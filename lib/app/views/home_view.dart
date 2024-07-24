import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/widgets/homescreenwidgets/driver_data_container.dart';
import 'package:speed_meter_app/app/widgets/homescreenwidgets/first_button_row.dart';
import 'package:speed_meter_app/app/widgets/package_alert_dialog_widget.dart';
import 'package:speed_meter_app/utils/colors.dart';
import 'package:speed_meter_app/utils/styles.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});

  Future<void> _showDialog(
      BuildContext context, Axis direction, bool isTablet) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PackageAlertDialogWidget(
          rideController: rideController,
          direction: direction,
          orientation: isTablet,
        );
      },
    );
  }

  RideController rideController = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMainColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('SpeeXo Drive', style: appBarTextStyle),
        backgroundColor: lightMainColor,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isTablet = constraints.maxWidth >= 600;
            Axis direction = isTablet ? Axis.horizontal : Axis.vertical;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DriverDataWidgetContainer(isTablet: isTablet),
                const SizedBox(
                  height: 4,
                ),
                const HomeScreenFirstButtonRow(),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showDialog(context, direction, isTablet);
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
                                    Icons.drive_eta,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Go",
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
                                    Icons.settings,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Settings",
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
