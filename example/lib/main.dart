import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_heatmap_grid/flutter_heatmap_grid.dart';
import 'novel_cover_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heatmap Grid Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// 首页 - 案例导航
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Heatmap Grid'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '案例展示',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // 小说扉页案例
            _buildCaseCard(
              context,
              title: '小说扉页',
              description: '展示书籍详情页，底部使用热力图展示近3个月阅读频率',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NovelCoverPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            // 原有热力图演示
            _buildCaseCard(
              context,
              title: '热力图演示',
              description: '完整的热力图功能演示，包含各种配置选项',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DemoPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseCard(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  title == '小说扉页' ? Icons.book : Icons.grid_on,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  HeatmapColorScheme _selectedScheme = HeatmapColorScheme.github;
  bool _showValues = false;
  bool _reverseColors = false;
  double _cellSize = 12.0;
  LegendStyle _legendStyle = LegendStyle.discrete;
  LegendPosition _legendPosition = LegendPosition.bottom;
  // 生成示例数据
  late List<DateHeatmapCell> _dateData;
  late List<DateHeatmapCell> _lastThreeMonthsData;

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  void _generateData() {
    final random = Random(42);

    // 日期数据 - 生成过去一年的数据
    final now = DateTime.now();
    final startDate = DateTime(now.year - 1, now.month, now.day);
    _dateData = List.generate(365, (i) {
      final date = startDate.add(Duration(days: i));
      return DateHeatmapCell(
        date: date,
        value: random.nextDouble() * 100,
      );
    });

    // 后三个月数据
    final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
    _lastThreeMonthsData = List.generate(90, (i) {
      final date = threeMonthsAgo.add(Duration(days: i));
      return DateHeatmapCell(
        date: date,
        value: random.nextDouble() * 100,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Heatmap Grid Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GitHub 风格日期热力图
            const Text(
              'GitHub 风格日期热力图',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDateHeatmapExample(),
            const SizedBox(height: 32),

            // 控制面板
            _buildControlPanel(),
            const SizedBox(height: 24),

            // 自定义热力图展示
            const Text(
              '自定义日期热力图',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDateCustomHeatmap(),
            const SizedBox(height: 32),

            // 后三个月测试
            const Text(
              '仅展示后三个月数据',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildLastThreeMonthsHeatmap(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeatmapExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '使用 HeatmapGrid.githubStyle() + 日期数据',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            HeatmapGrid.githubStyle(
              dateData: _dateData,
              colorMapping: const ColorMapping.github(),
              showMonthLabels: true,
              showRowLabels: true,
              showLegend: true,
              scrollable: true,
              onCellTap: (cell) {
                final date = cell.data as DateTime;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '点击: ${date.year}-${date.month}-${date.day}, 值: ${cell.value.toStringAsFixed(2)}',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              tooltipBuilder: (cell) {
                final date = cell.data as DateTime;
                return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}\n值: ${cell.value.toStringAsFixed(1)}';
              },
              legendLessText: '少',
              legendMoreText: '多',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCustomHeatmap() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: HeatmapGrid(
          dateData: _dateData,
          colorMapping: ColorMapping(
            scheme: _selectedScheme,
            reverse: _reverseColors,
          ),
          cellSize: _cellSize,
          rowsPerWeek: 7,
          showMonthLabels: true,
          showRowLabels: true,
          showLegend: true,
          legendStyle: _legendStyle,
          legendPosition: _legendPosition,
          legendLessText: '少',
          legendMoreText: '多',
          scrollable: true,
          onCellTap: (cell) {
            final date = cell.data as DateTime;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '点击: ${date.year}-${date.month}-${date.day}',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          tooltipBuilder: (cell) {
            final date = cell.data as DateTime;
            return '${date.year}-${date.month}-${date.day}\n值: ${cell.value.toStringAsFixed(1)}';
          },
        ),
      ),
    );
  }

  Widget _buildLastThreeMonthsHeatmap() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '数据范围: ${_lastThreeMonthsData.first.date.toString().split(' ').first} ~ ${_lastThreeMonthsData.last.date.toString().split(' ').first}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            HeatmapGrid.githubStyle(
              dateData: _lastThreeMonthsData,
              colorMapping: const ColorMapping.github(),
              showMonthLabels: true,
              showRowLabels: true,
              showLegend: true,
              scrollable: true,
              onCellTap: (cell) {
                final date = cell.data as DateTime;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '点击: ${date.year}-${date.month}-${date.day}, 值: ${cell.value.toStringAsFixed(2)}',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              tooltipBuilder: (cell) {
                final date = cell.data as DateTime;
                return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}\n值: ${cell.value.toStringAsFixed(1)}';
              },
              legendLessText: '少',
              legendMoreText: '多',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '配置选项',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // 颜色方案选择
            Row(
              children: [
                const Text('颜色方案: '),
                const SizedBox(width: 8),
                DropdownButton<HeatmapColorScheme>(
                  value: _selectedScheme,
                  items: HeatmapColorScheme.values.map((scheme) {
                    return DropdownMenuItem(
                      value: scheme,
                      child: Text(_getSchemeName(scheme)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedScheme = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 图例样式
            Row(
              children: [
                const Text('图例样式: '),
                const SizedBox(width: 8),
                DropdownButton<LegendStyle>(
                  value: _legendStyle,
                  items: const [
                    DropdownMenuItem(
                      value: LegendStyle.gradient,
                      child: Text('渐变色条'),
                    ),
                    DropdownMenuItem(
                      value: LegendStyle.discrete,
                      child: Text('离散色块'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _legendStyle = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 图例位置
            Row(
              children: [
                const Text('图例位置: '),
                const SizedBox(width: 8),
                DropdownButton<LegendPosition>(
                  value: _legendPosition,
                  items: const [
                    DropdownMenuItem(
                      value: LegendPosition.left,
                      child: Text('左侧'),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.right,
                      child: Text('右侧'),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.top,
                      child: Text('顶部'),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.bottom,
                      child: Text('底部'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _legendPosition = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 显示数值
            Row(
              children: [
                const Text('显示数值: '),
                Switch(
                  value: _showValues,
                  onChanged: (value) {
                    setState(() {
                      _showValues = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 反转颜色
            Row(
              children: [
                const Text('反转颜色: '),
                Switch(
                  value: _reverseColors,
                  onChanged: (value) {
                    setState(() {
                      _reverseColors = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 单元格大小
            Row(
              children: [
                const Text('单元格大小: '),
                Expanded(
                  child: Slider(
                    value: _cellSize,
                    min: 8,
                    max: 20,
                    divisions: 12,
                    label: _cellSize.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _cellSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getSchemeName(HeatmapColorScheme scheme) {
    switch (scheme) {
      case HeatmapColorScheme.heat:
        return '热力图';
      case HeatmapColorScheme.coolWarm:
        return '冷暖';
      case HeatmapColorScheme.grayscale:
        return '灰度';
      case HeatmapColorScheme.greenRed:
        return '绿红';
      case HeatmapColorScheme.purpleOrange:
        return '紫橙';
      case HeatmapColorScheme.ocean:
        return '海洋';
      case HeatmapColorScheme.github:
        return 'GitHub 绿色';
      case HeatmapColorScheme.githubBlue:
        return 'GitHub 蓝色';
      case HeatmapColorScheme.custom:
        return '自定义';
    }
  }
}
