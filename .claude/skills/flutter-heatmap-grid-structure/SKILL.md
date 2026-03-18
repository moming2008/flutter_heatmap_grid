---
name: flutter-heatmap-grid-structure
description: |
  Flutter 网格热力图插件项目结构指南。当需要了解或修改 flutter_heatmap_grid 插件时使用此技能。
  触发场景：(1) 添加新功能到热力图组件 (2) 修改颜色方案或样式 (3) 扩展数据模型 (4) 修复组件相关 bug (5) 添加新的交互功能 (6) 使用日期热力图功能
---

# Flutter Heatmap Grid 项目结构

## 项目概述

Flutter 网格热力图组件 - 以网格形式展示数据，通过颜色深浅表示数值大小。支持传统二维数组模式和日期热力图模式。

- **版本**: 0.0.1
- **SDK**: ^3.9.2
- **Flutter**: >=3.3.0
- **平台**: Android, iOS, Web
- **仓库**: https://github.com/moming2008/flutter_heatmap_grid

## 目录结构

```
lib/
├── flutter_heatmap_grid.dart      # 主入口，导出所有公开 API
├── flutter_heatmap_grid_web.dart  # Web 平台插件注册
└── src/
    ├── heatmap_grid.dart          # 核心组件 HeatmapGrid + DateHeatmapCell
    ├── models/
    │   ├── color_mapping.dart     # 颜色映射配置 + HeatmapColorScheme 枚举
    │   └── grid_data.dart         # 网格数据模型 GridData + GridCell
    └── utils/
        └── color_interpolator.dart # 颜色插值工具 + LegendItem
```

## 两种使用模式

### 模式一：传统二维数组模式

使用 `GridData` 传入二维数组数据。

```dart
HeatmapGrid(
  data: GridData(values: [[1, 2], [3, 4]]),
  colorMapping: ColorMapping.heat(),
)
```

### 模式二：日期热力图模式（推荐）

使用 `dateData` 传入日期数据列表，类似 GitHub 贡献图风格。

```dart
HeatmapGrid.githubStyle(
  dateData: [
    DateHeatmapCell(date: DateTime(2024, 1, 1), value: 10),
    DateHeatmapCell(date: DateTime(2024, 1, 2), value: 25),
    // ...
  ],
  showMonthLabels: true,
  scrollable: true,
)
```

## 核心类

### HeatmapGrid (`src/heatmap_grid.dart`)

核心热力图组件，StatelessWidget。

**通用属性**:
- `colorMapping: ColorMapping` - 颜色映射（默认 heat）
- `cellSize: double` - 单元格大小（默认 40.0，githubStyle 12.0）
- `cellSpacing: double` - 间距（默认 2.0，githubStyle 3.0）
- `cellRadius: double` - 圆角（默认 4.0，githubStyle 2.0）
- `cellBorder: Border?` - 单元格边框
- `showValues: bool` - 显示数值（默认 false）
- `valueTextStyle: TextStyle?` - 数值文本样式
- `valueFormatter: String Function(double)?` - 数值格式化
- `showRowLabels/showColumnLabels: bool` - 显示标签
- `rowLabelStyle/columnLabelStyle: TextStyle?` - 标签样式
- `labelWidth/labelHeight: double` - 标签尺寸
- `labelSpacing: double` - 标签与网格间距（默认 8.0）
- `showLegend: bool` - 显示图例（默认 true）
- `legendPosition: LegendPosition` - 图例位置（默认 right）
- `legendStyle: LegendStyle` - 图例样式（默认 gradient）
- `legendItemCount: int` - 渐变图例项数量（默认 5）
- `legendSize: double` - 图例尺寸（默认 20.0）
- `legendLessText/legendMoreText: String?` - 离散图例文本
- `discreteLegendCount: int` - 离散图例色块数（默认 5）
- `columnLabelPosition: ColumnLabelPosition` - 列标签位置（默认 top）
- `rowLabelPosition: RowLabelPosition` - 行标签位置（默认 left）
- `padding: EdgeInsets` - 内边距（默认 zero）
- `backgroundColor: Color?` - 背景颜色
- `onCellTap/onCellLongPress/onCellHover` - 交互回调
- `tooltipBuilder: String Function(GridCell)?` - 提示构建器

**传统模式属性**:
- `data: GridData?` - 网格数据

**日期模式属性**:
- `dateData: List<DateHeatmapCell>?` - 日期数据列表
- `rowsPerWeek: int` - 每周行数（默认 7）
- `startDate: DateTime?` - 起始日期
- `endDate: DateTime?` - 结束日期
- `firstDayOfWeek: int` - 一周第一天（1=周一, 7=周日，默认 1）
- `showMonthLabels: bool` - 显示月份标签（默认 false）
- `monthLabelStyle: TextStyle?` - 月份标签样式
- `monthLabelHeight: double` - 月份标签高度（默认 20.0）
- `monthNameBuilder: String Function(int)?` - 月份名称生成器
- `scrollable: bool` - 是否支持水平滚动（默认 false）

**构造函数**:
- `HeatmapGrid()` - 默认构造
- `HeatmapGrid.githubStyle()` - GitHub 风格预设（启用离散图例、月份标签、滚动）

### DateHeatmapCell (`src/heatmap_grid.dart`)

日期热力图单元格数据模型。

```dart
DateHeatmapCell({
  required DateTime date,      // 日期
  required double value,       // 数值
  Color? customColor,          // 覆盖自动颜色
  dynamic data,                // 附加数据
})

// 创建副本
copyWith({...})
```

### GridData (`src/models/grid_data.dart`)

传统网格数据模型。

```dart
GridData({
  required List<List<double>> values,
  List<String>? rowLabels,
  List<String>? columnLabels,
})

// 工厂方法
GridData.sample({rows: 10, cols: 10, minVal: 0, maxVal: 100})
```

**属性**: `rows`, `cols`, `minValue`, `maxValue`
**方法**: `getValue(row, col)`, `getCell(row, col)`

### GridCell (`src/models/grid_data.dart`)

单元格数据模型。

```dart
GridCell({
  required double value,
  required int row,
  required int col,
  Color? customColor,  // 覆盖自动颜色
  String? label,
  dynamic data,         // 附加数据
})
```

### ColorMapping (`src/models/color_mapping.dart`)

颜色映射配置。

**工厂构造函数**:
- `ColorMapping.heat()` - 蓝→青→绿→黄→红
- `ColorMapping.grayscale()` - 黑→白
- `ColorMapping.github()` - GitHub 绿色（5级离散）
- `ColorMapping.githubBlue()` - GitHub 蓝色（5级离散）
- `ColorMapping.custom(colors: [...])` - 自定义

**属性**:
- `scheme: HeatmapColorScheme` - 颜色方案
- `customColors: List<Color>?` - 自定义颜色列表
- `minValue/maxValue: double?` - 值范围
- `nullColor: Color` - 无效值颜色（默认 #CCCCCC）
- `reverse: bool` - 是否反转颜色

### ColorInterpolator (`src/utils/color_interpolator.dart`)

颜色插值工具。

**属性**:
- `colorMapping: ColorMapping` - 颜色映射配置
- `minValue/maxValue: double` - 值范围

**方法**:
- `getColor(double value)` - 获取值对应的颜色
- `getLegendItems({count: 5})` - 获取图例数据

### LegendItem (`src/utils/color_interpolator.dart`)

图例项。

```dart
LegendItem({
  required double value,
  required Color color,
})
```

## 枚举类型

| 枚举 | 值 | 说明 |
|------|-----|------|
| `LegendPosition` | left, right, top, bottom | 图例位置 |
| `LegendStyle` | gradient, discrete | 图例样式 |
| `HeatmapColorScheme` | heat, coolWarm, grayscale, greenRed, purpleOrange, ocean, github, githubBlue, custom | 颜色方案 |
| `ColumnLabelPosition` | top, bottom | 列标签位置 |
| `RowLabelPosition` | left, right | 行标签位置 |

## 预定义颜色方案

| 方案 | 颜色序列 |
|------|----------|
| `heat` | 蓝 → 青 → 绿 → 黄 → 红 |
| `coolWarm` | 蓝 → 白 → 红 |
| `grayscale` | 黑 → 白 |
| `greenRed` | 绿 → 黄 → 红 |
| `purpleOrange` | 紫 → 橙 |
| `ocean` | 深蓝 → 浅蓝 → 白 |
| `github` | #EBEDF0 → #9BE9A8 → #40C463 → #30A14E → #216E39 |
| `githubBlue` | #EBEDF0 → #9ECFFF → #5CB4F5 → #2B8FD8 → #0E5E8F |

## 使用建议

### 日期热力图最佳实践

1. **数据准备**：
```dart
// 生成过去一年的数据
final now = DateTime.now();
final startDate = DateTime(now.year - 1, now.month, now.day);
final dateData = List.generate(365, (i) {
  return DateHeatmapCell(
    date: startDate.add(Duration(days: i)),
    value: randomValue,
  );
});
```

2. **使用 githubStyle 构造函数**：
```dart
HeatmapGrid.githubStyle(
  dateData: dateData,
  showMonthLabels: true,    // 显示月份标签
  scrollable: true,         // 启用水平滚动
)
```

3. **自定义月份名称**：
```dart
monthNameBuilder: (month) => ['Jan', 'Feb', 'Mar', ...][month - 1],
```

4. **处理点击事件**：
```dart
onCellTap: (cell) {
  final date = cell.data as DateTime;
  print('点击: ${date.year}-${date.month}-${date.day}');
},
```

5. **自定义提示文本**：
```dart
tooltipBuilder: (cell) {
  final date = cell.data as DateTime;
  return '${date.year}-${date.month}-${date.day}\n值: ${cell.value}';
},
```

### 只展示部分日期范围

```dart
// 只展示后三个月
final threeMonthsAgo = DateTime.now().subtract(Duration(days: 90));
final recentData = allData.where((d) => d.date.isAfter(threeMonthsAgo)).toList();

HeatmapGrid.githubStyle(
  dateData: recentData,
  scrollable: true,
)
```

### 设置一周起始日

```dart
// 美国习惯：周日为第一天
HeatmapGrid.githubStyle(
  dateData: dateData,
  firstDayOfWeek: 7,  // 7 = 周日
)

// 中国习惯：周一为第一天（默认）
HeatmapGrid.githubStyle(
  dateData: dateData,
  firstDayOfWeek: 1,  // 1 = 周一
)
```

## 扩展指南

### 添加新颜色方案

1. 在 `HeatmapColorScheme` 枚举（`color_mapping.dart`）添加新值
2. 在 `ColorMapping._getSchemeColors()` 添加颜色定义
3. (可选) 添加工厂构造函数

### 添加新交互

在 `HeatmapGrid` 类中：
- 添加新的回调属性（如 `onCellDoubleTap`）
- 在 `_buildCell()` 或 `_buildDateCell()` 方法中添加事件处理

### 修改单元格渲染

- 传统模式：修改 `_buildCell()` 方法
- 日期模式：修改 `_buildDateCell()` 方法

### 修改月份标签

修改 `_buildMonthLabels()` 方法和 `_getDefaultMonthName()` 方法。

### 修改行标签（星期）

修改 `_buildDateRowLabels()` 方法和 `_getWeekdayName()` 方法。

## 导出文件

`flutter_heatmap_grid.dart` 导出:
- `HeatmapGrid`
- `ColorMapping`, `HeatmapColorScheme`
- `GridData`, `GridCell`
- `DateHeatmapCell`
- `ColorInterpolator`, `LegendItem`
- `LegendPosition`, `LegendStyle`, `ColumnLabelPosition`, `RowLabelPosition`

## 内部类

- `_DateGridInfo` - 日期网格计算信息（私有类）
- `_HeatColorMapping`, `_GrayscaleColorMapping`, `_GitHubColorMapping`, `_GitHubBlueColorMapping` - 颜色映射工厂实现（私有类）
