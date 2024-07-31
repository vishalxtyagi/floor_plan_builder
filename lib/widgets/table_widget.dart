import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/table_model.dart';

class TableWidget extends StatefulWidget {
  final TableModel table;
  final Map<String, String>? svgData;
  final Function(TableModel) onTap;

  const TableWidget(
      {Key? key,
      required this.table,
      required this.svgData,
      required this.onTap})
      : super(key: key);

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  String _tableColor = 'green';

  void _toggleColor() {
    setState(() {
      _tableColor = _tableColor == 'green' ? 'orange' : 'green';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.svgData == null) {
      return Container();
    }

    return Positioned(
      left: widget.table.x,
      top: widget.table.y,
      child: GestureDetector(
        onTap: () {
          _toggleColor();
          widget.onTap(widget.table);
        },
        child: Stack(
          children: [
            SvgPicture.string(
              widget.svgData![_tableColor]!,
              width: 50,
              height: 50,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                child: Text(
                  widget.table.name,
                  style: TextStyle(
                      fontSize: widget.table.scale * 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
