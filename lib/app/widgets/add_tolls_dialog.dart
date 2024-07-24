import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/add_tolls_controller.dart';

class AddTollsDialogWidget extends StatelessWidget {
  AddTollsDialogWidget({super.key, required this.sizeFor});

  final bool sizeFor;
  final TollController tollController = Get.put(TollController());

  void showaddNewToll(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Toll Name',
                      labelStyle: const TextStyle(fontSize: 16.0),
                      hintText: 'Enter name',
                      hintStyle: const TextStyle(fontSize: 14.0),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price of new Toll',
                      labelStyle: const TextStyle(fontSize: 16.0),
                      hintText: 'Enter price \$',
                      hintStyle: const TextStyle(fontSize: 14.0),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      tollController.addNewToll(nameController.value.text,
                          priceController.value.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add Toll'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Select Tolls'),
          IconButton(
              onPressed: () async {
                Navigator.of(context).pop();
                showaddNewToll(context);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
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
                        if (sizeFor) ...[
                          Text(
                            toll.name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            "\$${toll.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ] else if (!sizeFor) ...[
                          Text(
                            toll.name,
                          ),
                          Text("\$${toll.price.toStringAsFixed(2)}"),
                        ]
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
