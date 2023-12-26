import 'dart:math';

import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatefulWidget {
  final String brand;
  final String fuelType;
  final String vehicleNumber;
  final List<String> imageUrls;

  VehicleDetailsPage({
    required this.brand,
    required this.fuelType,
    required this.vehicleNumber,
    required this.imageUrls,
  });

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  late List<bool> imageVisibility;

  int generateModelNumber() {
    final Random _random = Random();
    return _random
        .nextInt(10000); // Generates a random number between 0 and 9999
  }

  @override
  void initState() {
    super.initState();
    imageVisibility = List.generate(widget.imageUrls.length, (_) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
        actions: [
          Icon(Icons.car_rental),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          if (!imageVisibility[index]) {
            return SizedBox.shrink();
          }
          return Card(
            color: Colors.deepPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Brand: ${widget.brand}'),
                  subtitle: Text('Fuel Type: ${widget.fuelType}'),
                ),
                ListTile(
                  subtitle: Text('Vehicle Number: ${widget.vehicleNumber}'),
                  title: Text('Model No.: ${generateModelNumber()}'),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Options'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.greenAccent,
                                      content: Text(
                                        'Vehicle added!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text('Add'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    imageVisibility[index] = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Remove'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Image.asset(
                      widget.imageUrls[index],
                      height: 250,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
