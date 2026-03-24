import 'package:flutter/material.dart';
import 'models/color_mapping.dart';
import 'models/grid_data.dart';
import 'utils/color_interpolator.dart';

/// 网格热力图组件
///
/// 用于以网格形式展示数据，通过颜色深浅表示数值大小
class HeatmapGrid extends StatelessWidget {
  /// 网格数据（传统二维数组方式）
  final GridData? data;

  /// 颜色映射配置
  final ColorMapping colorMapping;

  /// 单元格大小
  final double cellSize;

  /// 单元格间距
  final double cellSpacing;

  /// 单元格圆角
  final double cellRadius;

  /// 单元格边框
  final Border? cellBorder;

  /// 是否显示数值标签
  final bool showValues;

  /// 数值标签文本样式
  final TextStyle? valueTextStyle;

  /// 数值格式化函数
  final String Function(double value)? valueFormatter;

  /// 是否显示行标签
  final bool showRowLabels;

  /// 是否显示列标签
  final bool showColumnLabels;

  /// 行标签文本样式
  final TextStyle? rowLabelStyle;

  /// 列标签文本样式
  final TextStyle? columnLabelStyle;

  /// 标签宽度
  final double labelWidth;

  /// 标签高度
  final double labelHeight;

  /// 单元格点击回调
  final void Function(GridCell cell)? onCellTap;

  /// 单元格长按回调
  final void Function(GridCell cell)? onCellLongPress;

  /// 单元格悬停回调
  final void Function(GridCell cell)? onCellHover;

  /// 提示构建器
  final String Function(GridCell cell)? tooltipBuilder;

  /// 是否显示图例
  final bool showLegend;

  /// 图例位置
  final LegendPosition legendPosition;

  /// 图例项数量
  final int legendItemCount;

  /// 图例宽度（垂直方向时）或高度（水平方向时）
  final double legendSize;

  /// 整体内边距
  final EdgeInsets padding;

  /// 背景颜色
  final Color? backgroundColor;

  /// 图例样式
  final LegendStyle legendStyle;

  /// 离散图例"少"文本
  final String? legendLessText;

  /// 离散图例"多"文本
  final String? legendMoreText;

  /// 离散图例色块数量
  final int discreteLegendCount;

  /// 列标签位置
  final ColumnLabelPosition columnLabelPosition;

  /// 行标签位置
  final RowLabelPosition rowLabelPosition;

  /// 标签与网格的间距
  final double labelSpacing;

  // ============ 日期热力图相关参数 ============

  /// 日期数据列表（替代 data 参数）
  final List<DateHeatmapCell>? dateData;

  /// 每周的行数（默认7，可配置为5只显示工作日等）
  final int rowsPerWeek;

  /// 起始日期（当 dateData 为空时使用，用于生成空网格）
  final DateTime? startDate;

  /// 结束日期
  final DateTime? endDate;

  /// 一周的第一天（1=周一, 7=周日）
  final int firstDayOfWeek;

  /// 是否显示月份标签
  final bool showMonthLabels;

  /// 月份标签样式
  final TextStyle? monthLabelStyle;

  /// 月份标签高度
  final double monthLabelHeight;

  /// 月份名称生成器
  final String Function(int month)? monthNameBuilder;

  /// 星期名称生成器
  final String Function(int week)? weekdayNameBuilder;

  /// 是否在溢出时允许水平滚动
  final bool scrollable;

  const HeatmapGrid({
    super.key,
    this.data,
    this.colorMapping = const ColorMapping.heat(),
    this.cellSize = 40.0,
    this.cellSpacing = 2.0,
    this.cellRadius = 4.0,
    this.cellBorder,
    this.showValues = false,
    this.valueTextStyle,
    this.valueFormatter,
    this.showRowLabels = true,
    this.showColumnLabels = true,
    this.rowLabelStyle,
    this.columnLabelStyle,
    this.labelWidth = 60.0,
    this.labelHeight = 30.0,
    this.onCellTap,
    this.onCellLongPress,
    this.onCellHover,
    this.tooltipBuilder,
    this.showLegend = true,
    this.legendPosition = LegendPosition.right,
    this.legendItemCount = 5,
    this.legendSize = 20.0,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.legendStyle = LegendStyle.gradient,
    this.legendLessText,
    this.legendMoreText,
    this.discreteLegendCount = 5,
    this.columnLabelPosition = ColumnLabelPosition.top,
    this.rowLabelPosition = RowLabelPosition.left,
    this.labelSpacing = 8.0,
    // 日期热力图参数
    this.dateData,
    this.rowsPerWeek = 7,
    this.startDate,
    this.endDate,
    this.firstDayOfWeek = 1,
    this.showMonthLabels = false,
    this.monthLabelStyle,
    this.monthLabelHeight = 20.0,
    this.monthNameBuilder,
    this.weekdayNameBuilder,
    this.scrollable = false,
  });

  /// GitHub 风格预设构造函数
  const HeatmapGrid.githubStyle({
    super.key,
    this.data,
    this.colorMapping = const ColorMapping.github(),
    this.showRowLabels = true,
    this.showColumnLabels = false,
    this.showLegend = true,
    this.rowLabelStyle,
    this.columnLabelStyle,
    this.labelWidth = 40.0,
    this.labelHeight = 20.0,
    this.onCellTap,
    this.onCellLongPress,
    this.onCellHover,
    this.tooltipBuilder,
    this.legendLessText,
    this.legendMoreText,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.cellBorder,
    this.showValues = false,
    this.valueTextStyle,
    this.valueFormatter,
    // 日期热力图参数
    this.dateData,
    this.rowsPerWeek = 7,
    this.startDate,
    this.endDate,
    this.firstDayOfWeek = 1,
    this.showMonthLabels = true,
    this.monthLabelStyle,
    this.monthLabelHeight = 20.0,
    this.monthNameBuilder,
    this.weekdayNameBuilder,
    this.scrollable = true,
  })  : cellSize = 12.0,
        cellSpacing = 3.0,
        cellRadius = 2.0,
        legendStyle = LegendStyle.discrete,
        legendPosition = LegendPosition.bottom,
        legendItemCount = 5,
        legendSize = 10.0,
        discreteLegendCount = 5,
        columnLabelPosition = ColumnLabelPosition.top,
        rowLabelPosition = RowLabelPosition.left,
        labelSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    // 判断使用哪种模式
    if (dateData != null) {
      return _buildDateHeatmap(context);
    }

    // 传统模式
    if (data == null) {
      return const SizedBox.shrink();
    }

    final interpolator = ColorInterpolator(
      colorMapping: colorMapping,
      minValue: data!.minValue,
      maxValue: data!.maxValue,
    );

    return _buildTraditionalHeatmap(interpolator);
  }

  /// 构建日期热力图
  Widget _buildDateHeatmap(BuildContext context) {
    if (dateData!.isEmpty && startDate == null) {
      return const SizedBox.shrink();
    }

    // 确定日期范围
    final effectiveStartDate = startDate ?? dateData!.map((d) => d.date).reduce((a, b) => a.isBefore(b) ? a : b);
    final effectiveEndDate = endDate ?? dateData!.map((d) => d.date).reduce((a, b) => a.isAfter(b) ? a : b);

    // 创建日期到数据的映射
    final dateValueMap = <DateTime, DateHeatmapCell>{};
    for (final cell in dateData!) {
      dateValueMap[DateTime(cell.date.year, cell.date.month, cell.date.day)] = cell;
    }

    // 计算值的范围
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;
    for (final cell in dateData!) {
      if (cell.value < minValue) minValue = cell.value;
      if (cell.value > maxValue) maxValue = cell.value;
    }
    if (minValue == maxValue) {
      minValue -= 1;
      maxValue += 1;
    }

    final interpolator = ColorInterpolator(
      colorMapping: colorMapping,
      minValue: minValue,
      maxValue: maxValue,
    );

    // 计算网格结构
    final gridInfo = _calculateDateGridInfo(effectiveStartDate, effectiveEndDate);

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 顶部图例
        if (showLegend && legendPosition == LegendPosition.top)
          _buildDiscreteLegend(interpolator),
        // 主内容区域
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左侧图例
            if (showLegend && legendPosition == LegendPosition.left)
              _buildDiscreteLegend(interpolator),
            // 主网格区域
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 月份标签
                if (showMonthLabels)
                  _buildMonthLabels(gridInfo, dateValueMap),
                // 行标签和网格
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 左侧行标签
                    if (showRowLabels && rowLabelPosition == RowLabelPosition.left)
                      _buildDateRowLabels(gridInfo),
                    // 网格主体
                    _buildDateGrid(gridInfo, dateValueMap, interpolator),
                    // 右侧行标签
                    if (showRowLabels && rowLabelPosition == RowLabelPosition.right)
                      _buildDateRowLabels(gridInfo),
                  ],
                ),
              ],
            ),
            // 右侧图例
            if (showLegend && legendPosition == LegendPosition.right)
              _buildDiscreteLegend(interpolator),
          ],
        ),
        // 底部图例
        if (showLegend && legendPosition == LegendPosition.bottom)
          _buildDiscreteLegend(interpolator),
      ],
    );

    // 如果启用滚动，用 SingleChildScrollView 包裹
    if (scrollable) {
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: content,
      );
    }

    return Container(
      padding: padding,
      color: backgroundColor,
      child: content,
    );
  }

  /// 计算日期网格信息
  _DateGridInfo _calculateDateGridInfo(DateTime start, DateTime end) {
    // 调整起始日期到一周的第一天
    final startWeekday = start.weekday;
    final adjustedStart = start.subtract(Duration(days: (startWeekday - firstDayOfWeek + 7) % 7));

    // 计算总天数和列数
    final totalDays = end.difference(adjustedStart).inDays + 1;
    final totalCols = (totalDays / rowsPerWeek).ceil();

    return _DateGridInfo(
      adjustedStart: adjustedStart,
      originalStart: start,
      originalEnd: end,
      totalCols: totalCols,
      rowsPerWeek: rowsPerWeek,
    );
  }

  /// 构建月份标签
  Widget _buildMonthLabels(_DateGridInfo gridInfo, Map<DateTime, DateHeatmapCell> dateValueMap) {
    final monthLabels = <Widget>[];
    int? lastMonth;

    for (int col = 0; col < gridInfo.totalCols; col++) {
      // 获取该列第一个格子的日期
      final date = gridInfo.adjustedStart.add(Duration(days: col * rowsPerWeek));
      final month = date.month;

      // 如果是新月份且在日期范围内
      if (lastMonth != month &&
          !date.isBefore(gridInfo.originalStart) &&
          !date.isAfter(gridInfo.originalEnd)) {
        final monthName = monthNameBuilder?.call(month) ?? _getDefaultMonthName(month);
        monthLabels.add(
          Positioned(
            left: col * (cellSize + cellSpacing),
            child: SizedBox(
              width: cellSize * 4, // 月份标签宽度约4个格子
              height: monthLabelHeight,
              child: Text(
                monthName,
                style: monthLabelStyle ?? const TextStyle(fontSize: 10, color: Color(0xFF57606A)),
              ),
            ),
          ),
        );
        lastMonth = month;
      }
    }

    return SizedBox(
      height: monthLabelHeight,
      width: gridInfo.totalCols * (cellSize + cellSpacing),
      child: Stack(children: monthLabels),
    );
  }

  /// 获取默认月份名称
  String _getDefaultMonthName(int month) {
    const months = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
    return months[month - 1];
  }

  /// 构建日期热力图的行标签
  Widget _buildDateRowLabels(_DateGridInfo gridInfo) {
    final labels = <Widget>[];

    for (int row = 0; row < rowsPerWeek; row++) {
      // 计算该行对应的星期几
      final weekday = (firstDayOfWeek - 1 + row) % 7 + 1;
      final weekdayName = weekdayNameBuilder?.call(weekday) ?? _getWeekdayName(weekday);

      labels.add(
        Container(
          height: cellSize,
          margin: EdgeInsets.symmetric(vertical: cellSpacing / 2),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            weekdayName,
            style: rowLabelStyle ?? const TextStyle(fontSize: 10, color: Color(0xFF57606A)),
          ),
        ),
      );
    }

    return SizedBox(
      width: labelWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: labels,
      ),
    );
  }

  /// 获取星期名称
  String _getWeekdayName(int weekday) {
    const weekdays = ['', '一', '二', '三', '四', '五', '六', '日'];
    return weekdays[weekday];
  }

  /// 构建日期热力图网格
  Widget _buildDateGrid(
    _DateGridInfo gridInfo,
    Map<DateTime, DateHeatmapCell> dateValueMap,
    ColorInterpolator interpolator,
  ) {
    final rows = <Widget>[];

    for (int row = 0; row < rowsPerWeek; row++) {
      final cells = <Widget>[];

      for (int col = 0; col < gridInfo.totalCols; col++) {
        final dayIndex = col * rowsPerWeek + row;
        final cellDate = gridInfo.adjustedStart.add(Duration(days: dayIndex));
        final normalizedDate = DateTime(cellDate.year, cellDate.month, cellDate.day);

        // 检查是否在有效日期范围内
        final isValidDate = !cellDate.isBefore(gridInfo.originalStart) &&
            !cellDate.isAfter(gridInfo.originalEnd);

        // 获取该日期的数据
        final dateCell = dateValueMap[normalizedDate];
        final value = dateCell?.value ?? 0;
        final hasData = dateValueMap.containsKey(normalizedDate);

        // 确定颜色
        Color cellColor;
        if (!isValidDate) {
          cellColor = Colors.transparent;
        } else if (!hasData) {
          cellColor = colorMapping.nullColor;
        } else {
          cellColor = interpolator.getColor(value);
        }

        // 自定义颜色覆盖
        if (dateCell?.customColor != null) {
          cellColor = dateCell!.customColor!;
        }

        cells.add(_buildDateCell(cellDate, value, cellColor, isValidDate, hasData, dateCell));
      }

      rows.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: cells,
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }

  /// 构建日期单元格
  Widget _buildDateCell(
    DateTime date,
    double value,
    Color color,
    bool isValidDate,
    bool hasData,
    DateHeatmapCell? dateCell,
  ) {
    Widget cellWidget = Container(
      width: cellSize,
      height: cellSize,
      margin: EdgeInsets.all(cellSpacing / 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cellRadius),
        border: cellBorder,
      ),
    );

    // 添加交互
    if (isValidDate && (onCellTap != null || onCellLongPress != null || onCellHover != null || tooltipBuilder != null)) {
      final gridCell = GridCell(
        value: value,
        row: date.weekday - 1,
        col: 0,
        data: dateCell?.data ?? date,
      );

      if (tooltipBuilder != null) {
        cellWidget = Tooltip(
          message: tooltipBuilder!(gridCell),
          child: cellWidget,
        );
      }

      cellWidget = MouseRegion(
        onHover: onCellHover != null ? (_) => onCellHover!(gridCell) : null,
        child: GestureDetector(
          onTap: onCellTap != null ? () => onCellTap!(gridCell) : null,
          onLongPress: onCellLongPress != null ? () => onCellLongPress!(gridCell) : null,
          child: cellWidget,
        ),
      );
    }

    return cellWidget;
  }

  /// 构建传统热力图
  Widget _buildTraditionalHeatmap(ColorInterpolator interpolator) {
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 顶部图例
        if (showLegend && legendPosition == LegendPosition.top)
          _buildLegendByStyle(interpolator, cellSize),
        // 主内容区域
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 左侧图例
            if (showLegend && legendPosition == LegendPosition.left)
              _buildLegendByStyle(interpolator, cellSize),
            // 主网格区域
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 顶部列标签
                if (showColumnLabels && columnLabelPosition == ColumnLabelPosition.top)
                  _buildColumnLabels(cellSize),
                // 行标签和网格
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 左侧行标签
                    if (showRowLabels && rowLabelPosition == RowLabelPosition.left)
                      _buildRowLabels(cellSize),
                    // 网格主体
                    _buildGrid(interpolator, cellSize),
                    // 右侧行标签
                    if (showRowLabels && rowLabelPosition == RowLabelPosition.right)
                      _buildRowLabels(cellSize),
                  ],
                ),
                // 底部列标签
                if (showColumnLabels && columnLabelPosition == ColumnLabelPosition.bottom)
                  _buildColumnLabels(cellSize),
              ],
            ),
            // 右侧图例
            if (showLegend && legendPosition == LegendPosition.right)
              _buildLegendByStyle(interpolator, cellSize),
          ],
        ),
        // 底部图例
        if (showLegend && legendPosition == LegendPosition.bottom)
          _buildLegendByStyle(interpolator, cellSize),
      ],
    );

    return Container(
      padding: padding,
      color: backgroundColor,
      child: content,
    );
  }

  /// 根据样式构建图例
  Widget _buildLegendByStyle(ColorInterpolator interpolator, double actualCellSize) {
    switch (legendStyle) {
      case LegendStyle.gradient:
        return _buildGradientLegend(interpolator, actualCellSize);
      case LegendStyle.discrete:
        return _buildDiscreteLegend(interpolator);
    }
  }

  /// 构建离散图例（GitHub风格）
  Widget _buildDiscreteLegend(ColorInterpolator interpolator) {
    final legendItems = interpolator.getLegendItems(count: discreteLegendCount);
    final colors = legendItems.map((e) => e.color).toList();

    Widget legendWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          legendLessText ?? 'Less',
          style: const TextStyle(fontSize: 12, color: Color(0xFF57606A)),
        ),
        const SizedBox(width: 4),
        ...colors.map((color) => Container(
          width: legendSize,
          height: legendSize,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        )),
        const SizedBox(width: 4),
        Text(
          legendMoreText ?? 'More',
          style: const TextStyle(fontSize: 12, color: Color(0xFF57606A)),
        ),
      ],
    );

    // 根据图例位置添加间距
    switch (legendPosition) {
      case LegendPosition.left:
      case LegendPosition.right:
        return Padding(
          padding: EdgeInsets.only(
            left: legendPosition == LegendPosition.right ? 16 : 0,
            right: legendPosition == LegendPosition.left ? 16 : 0,
          ),
          child: legendWidget,
        );
      case LegendPosition.top:
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: legendWidget,
        );
      case LegendPosition.bottom:
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: legendWidget,
        );
    }
  }

  /// 构建列标签
  Widget _buildColumnLabels(double actualCellSize) {
    final gridData = data!;
    final labels = gridData.columnLabels ??
        List.generate(gridData.cols, (i) => '${i + 1}');

    return Padding(
      padding: EdgeInsets.only(
        left: showRowLabels ? labelWidth + cellSpacing : 0,
      ),
      child: SizedBox(
        height: labelHeight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: labels.map((label) {
            return Container(
              width: actualCellSize,
              margin: EdgeInsets.symmetric(horizontal: cellSpacing / 2),
              alignment: Alignment.center,
              child: Text(
                label,
                style: columnLabelStyle ??
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 构建行标签
  Widget _buildRowLabels(double actualCellSize) {
    final gridData = data!;
    final labels = gridData.rowLabels ??
        List.generate(gridData.rows, (i) => '${i + 1}');

    return SizedBox(
      width: labelWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: labels.map((label) {
          return Container(
            height: actualCellSize,
            margin: EdgeInsets.symmetric(vertical: cellSpacing / 2),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              label,
              style: rowLabelStyle ??
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 构建网格主体
  Widget _buildGrid(ColorInterpolator interpolator, double actualCellSize) {
    final gridData = data!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(gridData.rows, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(gridData.cols, (col) {
            final cell = gridData.getCell(row, col);
            final color = cell.customColor ?? interpolator.getColor(cell.value);

            return _buildCell(cell, color, actualCellSize);
          }),
        );
      }),
    );
  }

  /// 构建单个单元格
  Widget _buildCell(GridCell cell, Color color, double actualCellSize) {
    Widget cellWidget = Container(
      width: actualCellSize,
      height: actualCellSize,
      margin: EdgeInsets.all(cellSpacing / 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cellRadius),
        border: cellBorder,
      ),
      child: showValues
          ? Center(
              child: Text(
                valueFormatter != null
                    ? valueFormatter!(cell.value)
                    : cell.value.toStringAsFixed(1),
                style: valueTextStyle ??
                    TextStyle(
                      fontSize: 10,
                      color: _getContrastColor(color),
                    ),
              ),
            )
          : null,
    );

    // 添加交互
    if (onCellTap != null || onCellLongPress != null || onCellHover != null) {
      cellWidget = MouseRegion(
        onHover: onCellHover != null ? (_) => onCellHover!(cell) : null,
        child: GestureDetector(
          onTap: onCellTap != null ? () => onCellTap!(cell) : null,
          onLongPress:
              onCellLongPress != null ? () => onCellLongPress!(cell) : null,
          child: cellWidget,
        ),
      );
    }

    // 添加提示
    if (tooltipBuilder != null) {
      cellWidget = Tooltip(
        message: tooltipBuilder!(cell),
        child: cellWidget,
      );
    }

    return cellWidget;
  }

  /// 构建渐变图例
  Widget _buildGradientLegend(ColorInterpolator interpolator, double actualCellSize) {
    final gridData = data!;
    final legendItems = interpolator.getLegendItems(count: legendItemCount);

    // 根据图例位置决定布局方向
    final isVertical = legendPosition == LegendPosition.left ||
        legendPosition == LegendPosition.right;

    Widget legendWidget;

    if (isVertical) {
      // 垂直图例
      legendWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            valueFormatter != null
                ? valueFormatter!(legendItems.first.value)
                : legendItems.first.value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 4),
          Container(
            width: legendSize,
            height: actualCellSize * gridData.rows,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: legendItems.map((e) => e.color).toList(),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valueFormatter != null
                ? valueFormatter!(legendItems.last.value)
                : legendItems.last.value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 10),
          ),
        ],
      );
    } else {
      // 水平图例
      legendWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            valueFormatter != null
                ? valueFormatter!(legendItems.last.value)
                : legendItems.last.value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 10),
          ),
          const SizedBox(width: 4),
          Container(
            width: actualCellSize * gridData.cols * 0.5,
            height: legendSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: legendItems.map((e) => e.color).toList(),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            valueFormatter != null
                ? valueFormatter!(legendItems.first.value)
                : legendItems.first.value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 10),
          ),
        ],
      );
    }

    // 根据图例位置添加间距
    switch (legendPosition) {
      case LegendPosition.left:
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: legendWidget,
        );
      case LegendPosition.right:
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: legendWidget,
        );
      case LegendPosition.top:
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: legendWidget,
        );
      case LegendPosition.bottom:
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: legendWidget,
        );
    }
  }

  /// 获取与背景色形成对比的文字颜色
  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

/// 图例位置
enum LegendPosition {
  left,
  right,
  top,
  bottom,
}

/// 图例样式
enum LegendStyle {
  /// 渐变色条（默认）
  gradient,

  /// 离散色块（GitHub风格）
  discrete,
}

/// 列标签位置
enum ColumnLabelPosition {
  top,
  bottom,
}

/// 行标签位置
enum RowLabelPosition {
  left,
  right,
}

/// 日期热力图单元格数据
class DateHeatmapCell {
  /// 日期
  final DateTime date;

  /// 数值
  final double value;

  /// 自定义颜色（可选，覆盖自动计算的颜色）
  final Color? customColor;

  /// 附加数据（可选）
  final dynamic data;

  const DateHeatmapCell({
    required this.date,
    required this.value,
    this.customColor,
    this.data,
  });

  /// 创建副本
  DateHeatmapCell copyWith({
    DateTime? date,
    double? value,
    Color? customColor,
    dynamic data,
  }) {
    return DateHeatmapCell(
      date: date ?? this.date,
      value: value ?? this.value,
      customColor: customColor ?? this.customColor,
      data: data ?? this.data,
    );
  }
}

/// 日期网格信息（内部使用）
class _DateGridInfo {
  final DateTime adjustedStart;
  final DateTime originalStart;
  final DateTime originalEnd;
  final int totalCols;
  final int rowsPerWeek;

  _DateGridInfo({
    required this.adjustedStart,
    required this.originalStart,
    required this.originalEnd,
    required this.totalCols,
    required this.rowsPerWeek,
  });
}
