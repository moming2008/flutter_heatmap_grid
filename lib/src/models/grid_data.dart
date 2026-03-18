import 'dart:ui';
import 'dart:math';

/// 网格单元格数据模型
class GridCell {
  /// 单元格的值
  final double value;

  /// 单元格的行索引
  final int row;

  /// 单元格的列索引
  final int col;

  /// 可选的自定义颜色（覆盖自动计算的颜色）
  final Color? customColor;

  /// 可选的标签文本
  final String? label;

  /// 可选的附加数据
  final dynamic data;

  const GridCell({
    required this.value,
    required this.row,
    required this.col,
    this.customColor,
    this.label,
    this.data,
  });

  /// 创建副本
  GridCell copyWith({
    double? value,
    int? row,
    int? col,
    Color? customColor,
    String? label,
    dynamic data,
  }) {
    return GridCell(
      value: value ?? this.value,
      row: row ?? this.row,
      col: col ?? this.col,
      customColor: customColor ?? this.customColor,
      label: label ?? this.label,
      data: data ?? this.data,
    );
  }
}

/// 网格数据模型
class GridData {
  /// 二维数据数组
  final List<List<double>> values;

  /// 行标签
  final List<String>? rowLabels;

  /// 列标签
  final List<String>? columnLabels;

  /// 数据的最小值
  late final double minValue;

  /// 数据的最大值
  late final double maxValue;

  GridData({
    required this.values,
    this.rowLabels,
    this.columnLabels,
  }) {
    _calculateMinMax();
  }

  /// 计算最小值和最大值
  void _calculateMinMax() {
    final flatValues = values.expand((row) => row).toList();
    if (flatValues.isEmpty) {
      minValue = 0;
      maxValue = 1;
      return;
    }
    minValue = flatValues.reduce((a, b) => a < b ? a : b);
    maxValue = flatValues.reduce((a, b) => a > b ? a : b);

    // 如果所有值相同，设置一个范围
    if (minValue == maxValue) {
      minValue = minValue - 1;
      maxValue = maxValue + 1;
    }
  }

  /// 获取行数
  int get rows => values.length;

  /// 获取列数
  int get cols => values.isNotEmpty ? values[0].length : 0;

  /// 获取指定位置的值
  double getValue(int row, int col) {
    if (row < 0 || row >= rows || col < 0 || col >= cols) {
      return 0;
    }
    return values[row][col];
  }

  /// 获取指定位置的单元格
  GridCell getCell(int row, int col) {
    return GridCell(
      value: getValue(row, col),
      row: row,
      col: col,
    );
  }

  /// 创建示例数据
  factory GridData.sample({
    int rows = 10,
    int cols = 10,
    double minVal = 0,
    double maxVal = 100,
  }) {
    final random = Random();
    final values = List.generate(
      rows,
      (_) => List.generate(
        cols,
        (_) => minVal + random.nextDouble() * (maxVal - minVal),
      ),
    );
    return GridData(values: values);
  }
}
