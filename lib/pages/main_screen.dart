import 'package:flutter/material.dart';
import 'package:login_page/pages/vehicle_detail.dart';

//List of images

class Car {
  String brand;
  Map<String, List<String>> fuelTypeImages;

  Car(this.brand, this.fuelTypeImages);
}

List<Car> cars = [
  Car('Toyota', {
    'Petrol': [
      'assets/toyotap1.jpg',
      'assets/toyotap2.jpg',
      'assets/toyotap3.jpg',
      'assets/toyotap4.jpg',
      'assets/toyotap5.jpg',
    ],
  }),
  Car('Mahindra', {
    'Petrol': [
      'assets/mahip1.jpg',
      'assets/mahip2.jpg',
      'assets/mahip3.jpg',
      'assets/mahip4.jpg',
      'assets/mahip5.jpg',
    ],
  }),
  Car('BMW', {
    'Diesel': [
      'assets/bmwd1.jpg',
      'assets/bmwd2.jpg',
      'assets/bmwd3.jpg',
      'assets/bmwd4.jpg',
    ],
    'Petrol': [
      'assets/bmwp1.jpg',
      'assets/bmwp2.jpg',
      'assets/bmwp3.jpg',
      'assets/bmwp4.jpg',
      'assets/bmwp5.jpg',
    ],
  }),
];

class Bike {
  String brand;
  Map<String, List<String>> fuelTypeImages;

  Bike(this.brand, this.fuelTypeImages);
}

List<Bike> bikes = [
  Bike('Honda', {
    'Petrol': [
      'assets/hondab1.jpg',
      'assets/hondab2.jpg',
      'assets/hondab3.jpg',
      'assets/hondab4.jpg',
      'assets/hondab5.jpg',
    ],
  }),
  Bike('Yamaha', {
    'Petrol': [
      'assets/yamaha1.jpg',
      'assets/yamaha2.jpg',
      'assets/yamaha3.jpg',
      'assets/yamaha4.jpg',
      'assets/yamaha5.jpg',
    ],
  }),
  Bike('Hero', {
    'Petrol': [
      'assets/hero1.jpg',
      'assets/hero2.jpg',
      'assets/hero3.jpg',
      'assets/hero4.jpg',
      'assets/hero5.jpg',
    ],
  }),
];

//the main screen

class VehicleSelection extends StatefulWidget {
  @override
  _VehicleSelectionState createState() => _VehicleSelectionState();
}

class _VehicleSelectionState extends State<VehicleSelection>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? _selectedCarBrand;
  String? _selectedCarFuelType;
  String? _carNumber;
  String? _selectedBikeBrand;
  String? _selectedBikeFuelType;
  String? _bikeNumber;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Selection'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Cars'),
            Tab(text: 'Bikes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCarSelection(),
          _buildBikeSelection(),
        ],
      ),
    );
  }

  Widget _buildCarSelection() {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //creation of dropdown
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCarBrand,
                  hint: Text('Select Car Brand'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCarBrand = newValue;
                      _selectedCarFuelType = null;
                    });
                  },
                  items: cars.map((car) {
                    return DropdownMenuItem<String>(
                      value: car.brand,
                      child: Text(car.brand),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                if (_selectedCarBrand != null)
                  DropdownButtonFormField<String>(
                    value: _selectedCarFuelType,
                    hint: Text('Select Fuel Type'),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCarFuelType = newValue;
                      });
                    },
                    items: cars
                        .firstWhere((car) => car.brand == _selectedCarBrand)
                        .fuelTypeImages
                        .keys
                        .map((fuelType) {
                      return DropdownMenuItem<String>(
                        value: fuelType,
                        child: Text(fuelType),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20),
                if (_selectedCarFuelType != null)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Car Number',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _carNumber = value;
                    },
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(180, 50)),
                onPressed: () {
                  List<String> imageUrls = [];
                  if (_selectedBikeFuelType != null) {
                    final selectedCar = cars.firstWhere(
                      (cars) => cars.brand == _selectedCarBrand,
                      orElse: () => Car('', {}),
                    );

                    imageUrls =
                        selectedCar.fuelTypeImages[_selectedCarFuelType!] ?? [];
                  } else if (_selectedCarFuelType != null) {
                    final selectedCar = cars.firstWhere(
                      (car) => car.brand == _selectedCarBrand,
                      orElse: () => Car('', {}),
                    );

                    imageUrls =
                        selectedCar.fuelTypeImages[_selectedCarFuelType!] ?? [];
                  }

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return VehicleDetailsPage(
                        brand: _selectedCarBrand!,
                        fuelType: _selectedCarFuelType!,
                        vehicleNumber: _carNumber!,
                        imageUrls: imageUrls);
                  }));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBikeSelection() {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedBikeBrand,
                  hint: Text('Select Bike Brand'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBikeBrand = newValue;
                      _selectedBikeFuelType = null;
                    });
                  },
                  items: bikes.map((bike) {
                    return DropdownMenuItem<String>(
                      value: bike.brand,
                      child: Text(bike.brand),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                if (_selectedBikeBrand != null)
                  DropdownButtonFormField<String>(
                    value: _selectedBikeFuelType,
                    hint: Text('Select Fuel Type'),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedBikeFuelType = newValue;
                      });
                    },
                    items: bikes
                        .firstWhere((bike) => bike.brand == _selectedBikeBrand)
                        .fuelTypeImages
                        .keys
                        .map((fuelType) {
                      return DropdownMenuItem<String>(
                        value: fuelType.trim(),
                        child: Text(fuelType.trim()),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20),
                if (_selectedBikeFuelType != null)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Bike Number',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _bikeNumber = value;
                    },
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(180, 50)),
                onPressed: () {
                  List<String> imageUrls = [];
                  if (_selectedBikeFuelType != null) {
                    final selectedBike = bikes.firstWhere(
                      (bike) => bike.brand == _selectedBikeBrand,
                      orElse: () => Bike('', {}),
                    );

                    imageUrls =
                        selectedBike.fuelTypeImages[_selectedBikeFuelType!] ??
                            [];
                  } else if (_selectedCarFuelType != null) {
                    final selectedCar = cars.firstWhere(
                      (car) => car.brand == _selectedCarBrand,
                      orElse: () => Car('', {}),
                    );

                    imageUrls =
                        selectedCar.fuelTypeImages[_selectedCarFuelType!] ?? [];
                  }

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return VehicleDetailsPage(
                        brand: _selectedBikeBrand!,
                        fuelType: _selectedBikeFuelType!,
                        vehicleNumber: _bikeNumber!,
                        imageUrls: imageUrls);
                  }));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
