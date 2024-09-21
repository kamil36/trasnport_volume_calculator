import 'package:flutter/material.dart';

class TruckBoxCalculator extends StatefulWidget {
  @override
  _TruckBoxCalculatorState createState() => _TruckBoxCalculatorState();
}

class _TruckBoxCalculatorState extends State<TruckBoxCalculator> {
  final _truckLengthController = TextEditingController();
  final _truckWidthController = TextEditingController();
  final _truckHeightController = TextEditingController();
  final _truckWeightCapacityController = TextEditingController();
  final _boxLengthController = TextEditingController();
  final _boxWidthController = TextEditingController();
  final _boxHeightController = TextEditingController();
  final _boxWeightController = TextEditingController();

  double _result = 0;

  void _calculate() {
    final truckLength = num.tryParse(_truckLengthController.text) ?? 0;
    final truckWidth = num.tryParse(_truckWidthController.text) ?? 0;
    final truckHeight = num.tryParse(_truckHeightController.text) ?? 0;
    final truckWeightCapacity =
        num.tryParse(_truckWeightCapacityController.text) ?? 0;
    final boxLength = num.tryParse(_boxLengthController.text) ?? 0;
    final boxWidth = num.tryParse(_boxWidthController.text) ?? 0;
    final boxHeight = num.tryParse(_boxHeightController.text) ?? 0;
    final boxWeight = num.tryParse(_boxWeightController.text) ?? 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truck Box Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              constTextField(
                truckController: _truckLengthController,
                labletext: 'Truck Lenght (cm)',
              ),
              constTextField(
                truckController: _truckWidthController,
                labletext: 'Truck Width (cm)',
              ),
              constTextField(
                truckController: _truckHeightController,
                labletext: 'Truck Height (cm)',
              ),
              constTextField(
                truckController: _truckWeightCapacityController,
                labletext: 'Truck Weight Capacity (kg)',
              ),
              constTextField(
                truckController: _boxLengthController,
                labletext: 'Box Length (cm)',
              ),
              constTextField(
                truckController: _boxWidthController,
                labletext: 'Box Width (cm)',
              ),
              constTextField(
                truckController: _boxHeightController,
                labletext: 'Box Height (cm)',
              ),
              constTextField(
                truckController: _boxWeightController,
                labletext: 'Box Height (kg)',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculate,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20),
              Card(
                child: Text(
                  'Number of Boxes: ${_result.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class constTextField extends StatelessWidget {
  const constTextField({
    super.key,
    required TextEditingController truckController,
    required this.labletext,
  }) : _truckController = truckController;

  final TextEditingController _truckController;
  final String labletext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: TextField(
        controller: _truckController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: labletext),
      ),
    );
  }
}
