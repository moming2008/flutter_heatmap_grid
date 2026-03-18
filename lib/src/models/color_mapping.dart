import 'dart:ui';

/// 预定义的颜色方案
enum HeatmapColorScheme {
  /// 热力图：蓝色 -> 青色 -> 绿色 -> 黄色 -> 红色
  heat,

  /// 冷暖：蓝色 -> 白色 -> 红色
  coolWarm,

  /// 灰度：黑色 -> 白色
  grayscale,

  /// 绿红：绿色 -> 黄色 -> 红色
  greenRed,

  /// 紫橙：紫色 -> 橙色
  purpleOrange,

  /// 海洋：深蓝 -> 浅蓝 -> 白色
  ocean,

  /// GitHub 绿色：5级离散绿色（参考GitHub贡献图）
  github,

  /// GitHub 蓝色：5级离散蓝色
  githubBlue,

  /// 自定义颜色方案
  custom,
}

/// 颜色映射配置
class ColorMapping {
  /// 颜色方案
  final HeatmapColorScheme scheme;

  /// 自定义颜色列表（当 scheme 为 custom 时使用）
  final List<Color>? customColors;

  /// 最小值
  final double? minValue;

  /// 最大值
  final double? maxValue;

  /// 无效值的颜色
  final Color nullColor;

  /// 是否反转颜色
  final bool reverse;

  const ColorMapping({
    this.scheme = HeatmapColorScheme.heat,
    this.customColors,
    this.minValue,
    this.maxValue,
    this.nullColor = const Color(0xFFCCCCCC),
    this.reverse = false,
  });

  /// 获取颜色方案对应的颜色列表
  List<Color> get colors {
    if (scheme == HeatmapColorScheme.custom && customColors != null) {
      return reverse ? customColors!.reversed.toList() : customColors!;
    }

    final schemeColors = _getSchemeColors(scheme);
    return reverse ? schemeColors.reversed.toList() : schemeColors;
  }

  /// 获取预定义颜色方案的颜色列表
  static List<Color> _getSchemeColors(HeatmapColorScheme scheme) {
    switch (scheme) {
      case HeatmapColorScheme.heat:
        return const [
          Color(0xFF0000FF), // 蓝色
          Color(0xFF00FFFF), // 青色
          Color(0xFF00FF00), // 绿色
          Color(0xFFFFFF00), // 黄色
          Color(0xFFFF0000), // 红色
        ];
      case HeatmapColorScheme.coolWarm:
        return const [
          Color(0xFF0000FF), // 蓝色
          Color(0xFFFFFFFF), // 白色
          Color(0xFFFF0000), // 红色
        ];
      case HeatmapColorScheme.grayscale:
        return const [
          Color(0xFF000000), // 黑色
          Color(0xFFFFFFFF), // 白色
        ];
      case HeatmapColorScheme.greenRed:
        return const [
          Color(0xFF00FF00), // 绿色
          Color(0xFFFFFF00), // 黄色
          Color(0xFFFF0000), // 红色
        ];
      case HeatmapColorScheme.purpleOrange:
        return const [
          Color(0xFF800080), // 紫色
          Color(0xFFFFA500), // 橙色
        ];
      case HeatmapColorScheme.ocean:
        return const [
          Color(0xFF000080), // 深蓝
          Color(0xFF00BFFF), // 深天蓝
          Color(0xFFFFFFFF), // 白色
        ];
      case HeatmapColorScheme.github:
        return const [
          Color(0xFFEBEDF0), // none - 无贡献背景
          Color(0xFF9BE9A8), // level 1 - 低
          Color(0xFF40C463), // level 2 - 中
          Color(0xFF30A14E), // level 3 - 高
          Color(0xFF216E39), // level 4 - 最高
        ];
      case HeatmapColorScheme.githubBlue:
        return const [
          Color(0xFFEBEDF0), // none - 无贡献背景
          Color(0xFF9ECFFF), // level 1 - 低
          Color(0xFF5CB4F5), // level 2 - 中
          Color(0xFF2B8FD8), // level 3 - 高
          Color(0xFF0E5E8F), // level 4 - 最高
        ];
      case HeatmapColorScheme.custom:
        return const [
          Color(0xFF0000FF),
          Color(0xFF00FF00),
          Color(0xFFFF0000),
        ];
    }
  }

  /// 创建热力图颜色映射
  const factory ColorMapping.heat({
    double? minValue,
    double? maxValue,
    bool reverse,
  }) = _HeatColorMapping;

  /// 创建灰度颜色映射
  const factory ColorMapping.grayscale({
    double? minValue,
    double? maxValue,
    bool reverse,
  }) = _GrayscaleColorMapping;

  /// 创建 GitHub 绿色颜色映射（参考GitHub贡献图）
  const factory ColorMapping.github({
    double? minValue,
    double? maxValue,
    bool reverse,
  }) = _GitHubColorMapping;

  /// 创建 GitHub 蓝色颜色映射
  const factory ColorMapping.githubBlue({
    double? minValue,
    double? maxValue,
    bool reverse,
  }) = _GitHubBlueColorMapping;

  /// 创建自定义颜色映射
  factory ColorMapping.custom({
    required List<Color> colors,
    double? minValue,
    double? maxValue,
    bool reverse = false,
  }) {
    return ColorMapping(
      scheme: HeatmapColorScheme.custom,
      customColors: colors,
      minValue: minValue,
      maxValue: maxValue,
      reverse: reverse,
    );
  }
}

class _HeatColorMapping extends ColorMapping {
  const _HeatColorMapping({
    super.minValue,
    super.maxValue,
    super.reverse = false,
  }) : super(scheme: HeatmapColorScheme.heat);
}

class _GrayscaleColorMapping extends ColorMapping {
  const _GrayscaleColorMapping({
    super.minValue,
    super.maxValue,
    super.reverse = false,
  }) : super(scheme: HeatmapColorScheme.grayscale);
}

class _GitHubColorMapping extends ColorMapping {
  const _GitHubColorMapping({
    super.minValue,
    super.maxValue,
    super.reverse = false,
  }) : super(scheme: HeatmapColorScheme.github);
}

class _GitHubBlueColorMapping extends ColorMapping {
  const _GitHubBlueColorMapping({
    super.minValue,
    super.maxValue,
    super.reverse = false,
  }) : super(scheme: HeatmapColorScheme.githubBlue);
}
