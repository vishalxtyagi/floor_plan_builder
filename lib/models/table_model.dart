class TableModel {
  final int id;
  final String shape;
  final double x;
  final double y;
  final String name;
  final String seatingCapacity;
  final String availability;
  final double scale;

  TableModel({
    required this.id,
    required this.shape,
    required this.x,
    required this.y,
    required this.name,
    required this.seatingCapacity,
    required this.availability,
    this.scale = 1,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      shape: json['shape'],
      x: json['x'].toDouble(),
      y: json['y'].toDouble(),
      name: json['name'],
      seatingCapacity: json['seatingCapacity'],
      availability: json['availability'],
      scale: 1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableModel &&
        other.id == id &&
        other.shape == shape &&
        other.x == x &&
        other.y == y &&
        other.name == name &&
        other.seatingCapacity == seatingCapacity &&
        other.availability == availability;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shape.hashCode ^
        x.hashCode ^
        y.hashCode ^
        name.hashCode ^
        seatingCapacity.hashCode ^
        availability.hashCode;
  }
}
