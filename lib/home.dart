import 'package:flutter/material.dart';

class TruckBoxCalculator extends StatefulWidget {
  const TruckBoxCalculator({super.key});

  @override
  _TruckBoxCalculatorState createState() => _TruckBoxCalculatorState();
}

class _TruckBoxCalculatorState extends State<TruckBoxCalculator> {
  final _formkey = GlobalKey<FormState>();

  final _truckLengthController = TextEditingController();
  final _truckWidthController = TextEditingController();
  final _truckHeightController = TextEditingController();
  final _truckWeightController = TextEditingController();
  final _boxLengthController = TextEditingController();
  final _boxWidthController = TextEditingController();
  final _boxHeightController = TextEditingController();
  final _boxWeightController = TextEditingController();

  double? _result;

  void _calculate() {
    final truckLength = num.tryParse(_truckLengthController.text) ?? 0;
    final truckWidth = num.tryParse(_truckWidthController.text) ?? 0;
    final truckHeight = num.tryParse(_truckHeightController.text) ?? 0;
    final truckWeightCapacity = int.tryParse(_truckWeightController.text) ?? 0;
    final boxLength = num.tryParse(_boxLengthController.text) ?? 0;
    final boxWidth = num.tryParse(_boxWidthController.text) ?? 0;
    final boxHeight = num.tryParse(_boxHeightController.text) ?? 0;
    final boxWeight = num.tryParse(_boxWeightController.text) ?? 0;

    if (_formkey.currentState?.validate() ?? false) {
      try {
        if (truckLength > 0 &&
            truckWidth > 0 &&
            truckHeight > 0 &&
            truckWeightCapacity > 0 &&
            boxLength > 0 &&
            boxWidth > 0 &&
            boxHeight > 0 &&
            boxWeight > 0) {
          final truckVolume = truckLength * truckWidth * truckHeight;
          final boxVolume = boxLength * boxWidth * boxHeight;
          if (boxVolume == 0 || boxWeight == 0) {
            throw Exception('Box dimensions or weight cannot be zero.');
          }

          final boxesByVolume = truckVolume / boxVolume;

          final boxesByWeight = truckWeightCapacity / boxWeight;

          setState(() {
            _result =
                boxesByVolume < boxesByWeight ? boxesByVolume : boxesByWeight;
          });
        } else {
          setState(() {
            _result = 0;
          });
        }
      } catch (e) {
        setState(() {
          _result = 0;
        });
        print('Error occurred: $e');
      }
    }
  }

  void _clearFields() {
    _truckLengthController.clear();
    _truckWidthController.clear();
    _truckHeightController.clear();
    _truckWeightController.clear();
    _boxLengthController.clear();
    _boxWidthController.clear();
    _boxHeightController.clear();
    _boxWeightController.clear();
    setState(() {
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Truck Voulme Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                InputField(
                  truckController: _truckLengthController,
                  labletext: 'Truck Lenght (cm)',
                ),
                InputField(
                  truckController: _truckWidthController,
                  labletext: 'Truck Width (cm)',
                ),
                InputField(
                  truckController: _truckHeightController,
                  labletext: 'Truck Height (cm)',
                ),
                InputField(
                  truckController: _truckWeightController,
                  labletext: 'Truck Weight Capacity (kg)',
                ),
                InputField(
                  truckController: _boxLengthController,
                  labletext: 'Box Length (cm)',
                ),
                InputField(
                  truckController: _boxWidthController,
                  labletext: 'Box Width (cm)',
                ),
                InputField(
                  truckController: _boxHeightController,
                  labletext: 'Box Height (cm)',
                ),
                InputField(
                  truckController: _boxWeightController,
                  labletext: 'Box Height (kg)',
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _clearFields();
                        },
                        child: const Text(
                          'Clear',
                          style:
                              TextStyle(fontSize: 30, color: Colors.lightBlue),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          _calculate();
                        },
                        child: const Text(
                          'Calculate',
                          style:
                              TextStyle(fontSize: 30, color: Colors.lightBlue),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                        )),
                  ],
                ),
                Card(
                  child: Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    child: Center(
                      child: Text(
                        _result == null
                            ? "Number of Boxes: 0"
                            : 'Number of Boxes: ${_result!.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController truckController,
    required this.labletext,
  }) : _truckController = truckController;

  final TextEditingController _truckController;
  final String labletext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          controller: _truckController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labletext,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill all fields.';
            }
            final parsedValue = double.tryParse(value);
            if (parsedValue == null || parsedValue <= 0) {
              return 'Please enter a valid positive number.';
            }
            return null;
          },
        ),
      ),
    );
  }
}
