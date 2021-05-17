import 'package:demo_getx/controllers/carController.dart';
import 'package:demo_getx/models/car.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCar extends StatefulWidget {
  static const routeName = '/add-Car';

  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final carController = Get.put(CarController());

  final _priceFocus = FocusNode();

  final _form = GlobalKey<FormState>();

  var _car = Car(
    id: '',
    name: '',
    price: 0,
  );

  save() {
    _form.currentState!.save();
    carController.addCar(_car);
    Navigator.of(context).pop();
    print(_car.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18,
                top: 20,
              ),
              child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Car Name',
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocus);
                        },
                        onSaved: (value) {
                          _car = Car(
                              id: _car.id,
                              name: value.toString(),
                              price: _car.price);
                        },
                      ),
                      TextFormField(
                        focusNode: _priceFocus,
                        decoration: InputDecoration(
                          labelText: 'Car Price',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _car = Car(
                            id: _car.id,
                            name: _car.name,
                            price: int.parse(
                              value.toString(),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ElevatedButton(
                          onPressed: () => save(),
                          child: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text('Add Car'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
