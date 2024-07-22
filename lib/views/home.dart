import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/views/categories.dart';

import '../components/timeline_element.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _selectedItem = 'Central';
  late DateTime _date1;
  late DateTime _date2;
  List<String> _items = ['Central', 'Greater Accra', 'Eastern'];
  RangeValues _currentRangeValues = RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 20),
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
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Budget',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedItem,
                decoration: InputDecoration(
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
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Date Field 1',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() {
                            _date1 = date;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Date Field 2',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() {
                            _date2 = date;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  CustomText(text: "\$", fontSize: 20,),
                  Expanded(
                    child: RangeSlider(
                      values: _currentRangeValues,
                      min: 0,
                      max: 1000,
                      divisions: 100,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: Text("Continue"),
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
