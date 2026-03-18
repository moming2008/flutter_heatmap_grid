# GitHub 贡献热力图样式参考与扩展方案

## 一、GitHub 样式分析

### 1.1 颜色方案

GitHub 使用 **5级离散颜色** 表示贡献等级：

| 等级 | 颜色值 | 含义 |
|------|--------|------|
| 0 (none) | `#EBEDF0` | 无贡献 |
| 1 (low) | `#9BE9A8` | 1-9 次 |
| 2 (medium) | `#40C463` | 10-19 次 |
| 3 (high) | `#30A14E` | 20-29 次 |
| 4 (highest) | `#216E39` | 30+ 次 |

### 1.2 方块样式

| 属性 | 值 |
|------|-----|
| 尺寸 | 12 × 12 px |
| 间距 | 3 px（视觉间距约1px） |
| 圆角 | 2 px（GitHub实际有小圆角） |

### 1.3 标签布局

```
                    Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
                ┌─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
              Mon│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
                 │■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
              Wed│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
                 │■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
              Fri│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
                 │■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
                 │■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
                 │■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│■│
                 └─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┘
                 Less  ■ ■ ■ ■  More
```

- **月份标签**：顶部水平排列，与列对应
- **星期标签**：左侧垂直排列，与行对应（仅显示 Mon, Wed, Fri）
- **图例**：右下角，Less → 4个色块 → More

### 1.4 文本样式

| 元素 | 字号 | 颜色 |
|------|------|------|
| 月份标签 | 10px | `#57606A` |
| 星期标签 | 10px | `#57606A` |
| 图例文字 | 12px | `#57606A` |

---

## 二、当前项目与GitHub对比

| 特性 | GitHub | 当前项目 | 差异 |
|------|--------|---------|------|
| 默认方块大小 | 12px | 40px | -28px |
| 默认圆角 | 2px | 4px | -2px |
| 默认间距 | 3px | 2px | +1px |
| 颜色方案 | 5级离散绿色 | 连续渐变 | 不同 |
| 列标签位置 | 顶部 | 顶部 | 相同 |
| 行标签位置 | 左侧 | 左侧 | 相同 |
| 图例样式 | 水平色块 | 垂直渐变条 | 不同 |

---

## 三、已实现的扩展

### 3.1 新增颜色方案

在 `color_mapping.dart` 中添加：

| 方案 | 说明 |
|------|------|
| `HeatmapColorScheme.github` | GitHub 绿色（5级离散） |
| `HeatmapColorScheme.githubBlue` | GitHub 蓝色（5级离散） |

**颜色值：**
```dart
// GitHub 绿色
Color(0xFFEBEDF0),  // none
Color(0xFF9BE9A8),  // level 1
Color(0xFF40C463),  // level 2
Color(0xFF30A14E),  // level 3
Color(0xFF216E39),  // level 4

// GitHub 蓝色
Color(0xFFEBEDF0),  // none
Color(0xFF9ECFFF),  // level 1
Color(0xFF5CB4F5),  // level 2
Color(0xFF2B8FD8),  // level 3
Color(0xFF0E5E8F),  // level 4
```

### 3.2 新增图例样式

```dart
enum LegendStyle {
  gradient,  // 渐变色条（默认）
  discrete,  // 离散色块（GitHub风格）
}
```

### 3.3 新增标签位置配置

```dart
enum ColumnLabelPosition { top, bottom }
enum RowLabelPosition { left, right }
```

### 3.4 新增参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `legendStyle` | `LegendStyle` | `LegendStyle.gradient` | 图例样式 |
| `legendLessText` | `String?` | `'Less'` | 离散图例"少"文本 |
| `legendMoreText` | `String?` | `'More'` | 离散图例"多"文本 |
| `discreteLegendCount` | `int` | `5` | 离散图例色块数量 |
| `columnLabelPosition` | `ColumnLabelPosition` | `top` | 列标签位置 |
| `rowLabelPosition` | `RowLabelPosition` | `left` | 行标签位置 |
| `labelSpacing` | `double` | `8.0` | 标签与网格间距 |

### 3.5 GitHub 风格预设构造函数

```dart
const HeatmapGrid.githubStyle({
  required GridData data,
  ColorMapping? colorMapping,
  bool showRowLabels = true,
  bool showColumnLabels = true,
  bool showLegend = true,
  // ... 其他可选参数
})
```

**默认配置：**
- `cellSize`: 12.0
- `cellSpacing`: 3.0
- `cellRadius`: 2.0
- `colorMapping`: `ColorMapping.github()`
- `legendStyle`: `LegendStyle.discrete`
- `legendPosition`: `LegendPosition.bottom`
- `legendSize`: 10.0

---

## 四、使用示例

### 4.1 GitHub 默认风格

```dart
HeatmapGrid.githubStyle(
  data: myData,
  onCellTap: (cell) => print('Tapped: ${cell.value}'),
)
```

### 4.2 自定义颜色但保持GitHub布局

```dart
HeatmapGrid.githubStyle(
  data: myData,
  colorMapping: ColorMapping.custom(
    colors: [
      Color(0xFFFFF0F0),  // 浅红
      Color(0xFFFFCCCC),
      Color(0xFFFF9999),
      Color(0xFFFF6666),
      Color(0xFFFF0000),  // 深红
    ],
  ),
)
```

### 4.3 完全自定义

```dart
HeatmapGrid(
  data: myData,
  // 方块样式
  cellSize: 15,
  cellSpacing: 2,
  cellRadius: 3,
  // 颜色
  colorMapping: ColorMapping(scheme: HeatmapColorScheme.github),
  // 标签
  showRowLabels: true,
  showColumnLabels: true,
  rowLabelPosition: RowLabelPosition.left,
  columnLabelPosition: ColumnLabelPosition.top,
  rowLabelStyle: TextStyle(fontSize: 10, color: Colors.grey),
  columnLabelStyle: TextStyle(fontSize: 10, color: Colors.grey),
  labelSpacing: 4,
  // 图例
  showLegend: true,
  legendStyle: LegendStyle.discrete,
  legendPosition: LegendPosition.bottom,
  legendLessText: '少',
  legendMoreText: '多',
  discreteLegendCount: 5,
)
```

### 4.4 隐藏标签

```dart
HeatmapGrid.githubStyle(
  data: myData,
  showRowLabels: false,
  showColumnLabels: false,
  showLegend: false,
)
```

---

## 五、实现文件清单

| 文件 | 修改内容 |
|------|---------|
| `lib/src/models/color_mapping.dart` | 新增 `github`、`githubBlue` 颜色方案 |
| `lib/src/heatmap_grid.dart` | 新增 `LegendStyle`、`ColumnLabelPosition`、`RowLabelPosition` 枚举 |
| `lib/src/heatmap_grid.dart` | 新增 `legendStyle`、`legendLessText`、`legendMoreText` 等参数 |
| `lib/src/heatmap_grid.dart` | 新增 `githubStyle()` 构造函数 |
| `lib/src/heatmap_grid.dart` | 实现 `_buildDiscreteLegend()` 方法 |
| `example/lib/main.dart` | 更新示例代码 |

---

## 六、视觉效果对比

### 修改前
```
  1   2   3   4   5
┌───┬───┬───┬───┬───┐
│   │   │   │   │   │  A
│   │   │   │   │   │  B
│   │   │   │   │   │  C
└───┴───┴───┴───┴───┘
     ▓▓▓▓▓▓ (渐变条)
     0   100
```

### 修改后（GitHub风格）
```
        Jan Feb Mar Apr May
    ┌─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
Mon │■│■│■│■│■│■│■│■│■│■│
    │■│■│■│■│■│■│■│■│■│■│
Wed │■│■│■│■│■│■│■│■│■│■│
    │■│■│■│■│■│■│■│■│■│■│
Fri │■│■│■│■│■│■│■│■│■│■│
    └─┴─┴─┴─┴─┴─┴─┴─┴─┴─┘
    Less ■■■■■ More
```
