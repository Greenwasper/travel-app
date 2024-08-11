import 'package:flutter/material.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:febarproject/components/colors.dart';
import 'package:febarproject/views/categories.dart';

import '../components/timeline_element.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _selectedItem = 'Volta Region';
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _minController = TextEditingController(text: '0');
  final TextEditingController _maxController = TextEditingController(text: '0');
  final List<String> _items = ['Volta Region', 'Eastern Region', 'Greater Accra Region', 'Central Region', 'Upper East Region', 'Northern Region', 'Ahafo Region', 'Western Region'];
  RangeValues _currentRangeValues = const RangeValues(0, 0);
  double maxRange = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _budgetController.dispose();
    _minController.dispose();
    _maxController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TimelineElement(
                    icon: Icons.edit,
                    label: 'Basic Input',
                    selected: true,
                  ),
                  TimelineElement(
                    icon: Icons.category,
                    label: 'Categories',
                  ),
                  TimelineElement(
                    icon: Icons.done,
                    label: 'Done',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Budget',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  if(value != '' && int.parse(value) > 0){
                    _currentRangeValues = RangeValues(0, int.parse(value).toDouble());
                    maxRange = int.parse(value).toDouble();
                  } else{
                    _currentRangeValues = const RangeValues(0, 0);
                    maxRange = 0;
                  }

                  _maxController.text = value;

                  setState(() {

                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedItem,
                decoration: const InputDecoration(
                  labelText: "Region",
                  enabledBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue, width: 2),
                    // borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                    // borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: _items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minController,
                      decoration: const InputDecoration(
                        labelText: 'Min Budget',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _maxController,
                      decoration: const InputDecoration(
                        labelText: 'Max Budget',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const CustomText(text: "Min and Max Budget", fontSize: 20),
              const SizedBox(height: 5),
              Row(
                children: [
                  const CustomText(text: "¢", fontSize: 20,),
                  Expanded(
                    child: RangeSlider(
                      values: _currentRangeValues,
                      min: 0,
                      max: maxRange,
                      divisions: 100,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minController.text = values.start.toStringAsFixed(0);
                          _maxController.text = values.end.toStringAsFixed(0);
                          _currentRangeValues = values;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(region: _selectedItem, rangeValues: _currentRangeValues)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: const Text("Continue"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
