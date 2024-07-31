import 'package:flutter/material.dart';
import 'package:floor_plan_builder/floor_plan_builder.dart';
import 'package:floor_plan_builder/models/table_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<TableModel> selectedTables = [];

  void _onTableTap(TableModel table) {
    setState(() {
      if (selectedTables.contains(table)) {
        selectedTables.remove(table);
      } else {
        selectedTables.add(table);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tablesJson = [
      {
        "id": 1,
        "shape": "round-4",
        "x": 543.046875,
        "y": 33,
        "name": "Table 1",
        "seatingCapacity": "4",
        "availability": "available"
      },
      {
        "id": 2,
        "shape": "rectangle-2",
        "x": 350.046875,
        "y": 133,
        "name": "Table 2",
        "seatingCapacity": "2",
        "availability": "not-available"
      },
      {
        "id": 3,
        "shape": "rectangle-8",
        "x": 263.046875,
        "y": 358,
        "name": "Table 3",
        "seatingCapacity": "8",
        "availability": "available"
      },
      {
        "id": 4,
        "shape": "rectangle-6",
        "x": 151.0390625,
        "y": 53,
        "name": "Table 4",
        "seatingCapacity": "6",
        "availability": "available"
      }
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Floor Plan')),
        body: Column(
          children: [
            FloorPlanBuilder(
              tablesJson: tablesJson,
              onTableTap: _onTableTap,
              height: 350,
            ),
            Expanded(
              child: ListView(
                children: selectedTables
                    .map((table) => ListTile(
                          title: Text(table.name),
                          subtitle: Text(
                              'Seating capacity: ${table.seatingCapacity}'),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
