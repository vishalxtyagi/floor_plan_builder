import 'package:floor_plan_builder/models/table_model.dart';
import 'package:floor_plan_builder/utils/helper.dart';
import 'package:floor_plan_builder/widgets/table_widget.dart';
import 'package:flutter/material.dart';

class FloorPlanBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> tablesJson;
  final Function(TableModel) onTableTap;
  final double height;

  const FloorPlanBuilder({
    super.key,
    required this.tablesJson,
    required this.onTableTap,
    required this.height,
  });

  @override
  _FloorPlanBuilderState createState() => _FloorPlanBuilderState();
}

class _FloorPlanBuilderState extends State<FloorPlanBuilder> {
  late List<TableModel> tables;
  final Map<String, Map<String, String>> svgCache = {};
  late TransformationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    tables =
        widget.tablesJson.map((json) => TableModel.fromJson(json)).toList();
    _preloadSVGs();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _preloadSVGs() async {
    for (var table in tables) {
      final svgPath =
          'packages/floor_plan_builder/assets/table_shapes/${table.shape}.svg';
      svgCache[table.shape] = {
        'green': await AppHelper.coloredSvg(svgPath, color: Colors.green),
        'orange': await AppHelper.coloredSvg(svgPath, color: Colors.orange),
      };
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double minX = tables.map((t) => t.x).reduce((a, b) => a < b ? a : b);
    double minY = tables.map((t) => t.y).reduce((a, b) => a < b ? a : b);
    double maxX = tables.map((t) => t.x).reduce((a, b) => a > b ? a : b);
    double maxY = tables.map((t) => t.y).reduce((a, b) => a > b ? a : b);

    // Add padding to ensure tables aren't trimmed
    double padding = 100;
    double contentWidth = maxX - minX + padding * 2;
    double contentHeight = maxY - minY + padding * 2;

    double scaleX = MediaQuery.of(context).size.width / contentWidth;
    double scaleY = widget.height / contentHeight;
    double scale = scaleX < scaleY ? scaleX : scaleY;

    return Container(
      width: double.infinity,
      height: widget.height,
      color: Colors.black26,
      child: InteractiveViewer(
        transformationController: _controller,
        boundaryMargin: EdgeInsets.zero,
        minScale: 0.5,
        maxScale: 1.5,
        child: SizedBox(
          width: contentWidth * scale,
          height: contentHeight * scale,
          child: Stack(
            children: tables
                .map((table) => TableWidget(
                      table: TableModel(
                        id: table.id,
                        shape: table.shape,
                        x: (table.x - minX + padding) * scale,
                        y: (table.y - minY + padding) * scale,
                        name: table.name,
                        seatingCapacity: table.seatingCapacity,
                        availability: table.availability,
                        scale: scale,
                      ),
                      svgData: svgCache[table.shape],
                      onTap: widget.onTableTap,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
