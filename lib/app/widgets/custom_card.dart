import 'package:flutter/material.dart';
import 'package:speed_meter_app/utils/colors.dart';

class CustomCard extends StatelessWidget {
  final String heading;
  final String startRate;
  final String pricePerKm;
  final String waitingTime;
  final VoidCallback onTap;
  final bool orientation;

  const CustomCard({
    super.key,
    required this.heading,
    required this.startRate,
    required this.pricePerKm,
    required this.waitingTime,
    required this.onTap,
    required this.orientation,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: lightGradientColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Start - $startRate',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Price per km - $pricePerKm',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Waiting time - $waitingTime',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
