import 'package:demo_getx/controllers/carController.dart';
import 'package:demo_getx/views/addCar.dart';
import 'package:demo_getx/widgets/carList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final carController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Cars'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddCar.routeName);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: carController.fetchCar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              return ListView.builder(
                itemBuilder: (ctx, i) => CarList(
                  id: carController.car[i].id,
                  name: carController.car[i].name,
                  price: carController.car[i].price,
                ),
                itemCount: carController.car.length,
              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
