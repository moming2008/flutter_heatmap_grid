import 'dart:ui';
import 'dart:math' as math;
import '../models/color_mapping.dart';

/// 颜色插值工具类
class ColorInterpolator {
  /// 颜色映射配置
  final ColorMapping colorMapping;

  /// 最小值
  final double minValue;

  /// 最大值
  final double maxValue;

  ColorInterpolator({
    required this.colorMapping,
    required this.minValue,
    required this.maxValue,
  });

  /// 根据值获取对应的颜色
  Color getColor(double value) {
    // 处理无效值
    if (value.isNaN || value.isInfinite) {
      return colorMapping.nullColor;
    }

    // 计算归一化值 (0.0 - 1.0)
    final normalizedValue = _normalizeValue(value);

    // 获取颜色列表
    final colors = colorMapping.colors;

    // 如果只有一个颜色，直接返回
    if (colors.length == 1) {
      return colors[0];
    }

    // 计算在颜色梯度中的位置
    final position = normalizedValue * (colors.length - 1);
    final lowerIndex = position.floor();
    final upperIndex = math.min(lowerIndex + 1, colors.length - 1);
    final t = position - lowerIndex;

    // 在两个颜色之间插值
    return _lerpColor(colors[lowerIndex], colors[upperIndex], t);
  }

  /// 归一化值到 0.0 - 1.0 范围
  double _normalizeValue(double value) {
    final min = colorMapping.minValue ?? minValue;
    final max = colorMapping.maxValue ?? maxValue;

    if (max == min) {
      return 0.5;
    }

    final normalized = (value - min) / (max - min);
    return normalized.clamp(0.0, 1.0);
  }

  /// 在两个颜色之间进行线性插值
  Color _lerpColor(Color a, Color b, double t) {
    return Color.lerp(a, b, t) ?? a;
  }

  /// 获取颜色图例数据
  List<LegendItem> getLegendItems({int count = 5}) {
    final items = <LegendItem>[];
    final step = (maxValue - minValue) / (count - 1);

    for (int i = 0; i < count; i++) {
      final value = minValue + step * i;
      items.add(LegendItem(
        value: value,
        color: getColor(value),
      ));
    }

    return items;
  }
}

/// 图例项
class LegendItem {
  final double value;
  final Color color;

  const LegendItem({
    required this.value,
    required this.color,
  });
}
