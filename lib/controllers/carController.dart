import 'dart:convert';

import 'package:demo_getx/models/car.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CarController extends GetxController {
  var car = <Car>[].obs; // car variable. car -> List type. Car list. .obs

  @override
  void onInit() {
    // TODO: implement onInit
    fetchCar();
    super.onInit();
  }

  Future<void> fetchCar() async {
    var url = Uri.parse(
        "https://learngtx-d5949-default-rtdb.asia-southeast1.firebasedatabase.app/cars.json");

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Car> _car = [];
      extractedData.forEach((newId, newData) {
        _car.add(
          Car(
            id: newId,
            name: newData['name'],
            price: newData['price'],
          ),
        );
      });

      car.value = _car;
    } catch (error) {
      throw error;
    }
  }

  addCar(Car cars) async {
    var url = Uri.parse(
        "https://learngtx-d5949-default-rtdb.asia-southeast1.firebasedatabase.app/cars.json");

    final response = await http.post(
      url,
      body: json.encode(
        ({
          'name': cars.name,
          'price': cars.price,
        }),
      ),
    );
    final newCar = Car(
      id: json.decode(response.body)['name'],
      name: cars.name,
      price: cars.price,
    );
    car.add(newCar);
  }

  deleteCar(String id) async {
    var url = Uri.parse(
        "https://learngtx-d5949-default-rtdb.asia-southeast1.firebasedatabase.app/cars/$id.json");
    final carIndex = car.indexWhere((cars) => cars.id == id);
    var _car = car[carIndex];
    car.removeAt(carIndex);
    await http.delete(url).then((_) {
      _car = Car(id: '', name: '', price: 0);
    }).catchError((_) {
      car.insert(carIndex, _car);
    });
  }
}
