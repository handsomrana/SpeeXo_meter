import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedMeterGauge extends StatelessWidget {
  const SpeedMeterGauge({super.key, required this.speed, required this.size});

  final double speed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return size > 150
        ? SizedBox(
            width: size, height: size, //height and width of guage
            child: SfRadialGauge(
              title: const GaugeTitle(
                text: "Speed Meter",
              ), //title for guage
              enableLoadingAnimation: true,
              animationDuration: 1000, //pointer movement speed
              axes: <RadialAxis>[
                //Radial Guage Axix, use other Guage type here
                RadialAxis(
                  interval: 20,
                  showFirstLabel: true,
                  showLastLabel: true,
                  showTicks: true,
                  ticksPosition: ElementsPosition.inside,
                  labelsPosition: ElementsPosition.inside,
                  minimum: 0,
                  maximum: 200,
                  ranges: <GaugeRange>[
                    //Guage Ranges
                    GaugeRange(
                        startValue: 0,
                        endValue: 50, //start and end point of range
                        color: Colors.green,
                        startWidth: 15,
                        endWidth: 7),
                    GaugeRange(
                        startValue: 50,
                        endValue: 100,
                        color: Colors.yellow,
                        startWidth: 7,
                        endWidth: 7),
                    GaugeRange(
                        startValue: 100,
                        endValue: 150,
                        color: Colors.orange,
                        startWidth: 7,
                        endWidth: 7),
                    GaugeRange(
                        startValue: 150,
                        endValue: 200,
                        color: Colors.red,
                        startWidth: 7,
                        endWidth: 15),

                    //add more Guage Range here
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      onValueChanging: (value) {
                        // rcontroller.update();
                      },
                      value: speed.toDouble(),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                          alignment: Alignment.center,
                          child: speed > 1
                              ? Text(
                                  speed.toStringAsFixed(1),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  '0.0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        angle: 90,
                        positionFactor: 0.8),
                    const GaugeAnnotation(
                        angle: 90, positionFactor: 0.5, widget: Text("km/h"))
                  ],
                ),
              ],
            ),
          )
        : SizedBox(
            // color: Colors.red,
            width: size, height: size, //height and width of guage
            child: SfRadialGauge(
              // title: const GaugeTitle(
              //   text: "Speed Meter",
              // ), //title for guage
              enableLoadingAnimation: true,
              animationDuration: 1000, //pointer movement speed
              axes: <RadialAxis>[
                //Radial Guage Axix, use other Guage type here
                RadialAxis(
                  interval: 50,
                  // showFirstLabel: true,
                  showLastLabel: true,
                  labelsPosition: ElementsPosition.inside,
                  showTicks: true,

                  ticksPosition: ElementsPosition.inside,
                  // labelsPosition: ElementsPosition.inside,
                  minimum: 0,
                  maximum: 200,
                  ranges: <GaugeRange>[
                    //Guage Ranges
                    GaugeRange(
                        startValue: 0,
                        endValue: 50, //start and end point of range
                        color: Colors.green,
                        startWidth: 10,
                        endWidth: 8),
                    GaugeRange(
                        startValue: 50,
                        endValue: 100,
                        color: Colors.yellow,
                        startWidth: 8,
                        endWidth: 8),
                    GaugeRange(
                        startValue: 100,
                        endValue: 150,
                        color: Colors.orange,
                        startWidth: 8,
                        endWidth: 8),
                    GaugeRange(
                        startValue: 150,
                        endValue: 200,
                        color: Colors.red,
                        startWidth: 8,
                        endWidth: 10),

                    //add more Guage Range here
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      needleStartWidth: 0,
                      needleEndWidth: 4,
                      onValueChanging: (value) {
                        // rcontroller.update();
                      },
                      value: speed.toDouble(),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                          alignment: Alignment.center,
                          child: speed > 5
                              ? Text(
                                  speed.toStringAsFixed(1),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  '0.0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        angle: 90,
                        positionFactor: 0.9),
                    const GaugeAnnotation(
                        angle: 90, positionFactor: 0.6, widget: Text("km/h"))
                  ],
                ),
              ],
            ),
          );
  }
}
