import 'package:demo_getx/controllers/carController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarList extends StatelessWidget {
  final carController = Get.put(CarController());
  final String id;
  final String name;
  final int price;

  CarList({
    required this.id,
    required this.name,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        carController.deleteCar(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(
          right: 20,
        ),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        title: Text(name),
        trailing: Text('Rs $price'),
        leading: CircleAvatar(
          child: Text('1'),
        ),
      ),
    );
  }
}
