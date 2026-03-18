import 'package:flutter/material.dart';
import 'package:flutter_heatmap_grid/flutter_heatmap_grid.dart';

/// 小说扉页案例页面
class NovelCoverPage extends StatelessWidget {
  const NovelCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NovelCoverView(),
    );
  }
}

class NovelCoverView extends StatefulWidget {
  const NovelCoverView({super.key});

  @override
  State<NovelCoverView> createState() => _NovelCoverViewState();
}

class _NovelCoverViewState extends State<NovelCoverView> {
  // 零星的阅读数据 - 模拟刚开始读的状态
  late List<DateHeatmapCell> _readingData;

  @override
  void initState() {
    super.initState();
    _generateSporadicReadingData();
  }

  /// 生成零星的阅读数据，模拟刚开始读的状态
  /// 数据覆盖约5个月，确保热力图能占满宽度
  void _generateSporadicReadingData() {
    final now = DateTime.now();
    // 从5个月前开始，确保热力图占满宽度（约150天 = 21-22周）
    final startDate = DateTime(now.year, now.month - 5, now.day);

    // 创建一个空的数据列表
    _readingData = [];

    // 只添加几个零星的阅读记录
    // 最近几天有一些阅读记录
    final sporadicDays = [
      now.subtract(const Duration(days: 1)), // 昨天
      now.subtract(const Duration(days: 3)), // 3天前
      now.subtract(const Duration(days: 7)), // 一周前
      now.subtract(const Duration(days: 12)), // 12天前
      now.subtract(const Duration(days: 25)), // 25天前
      now.subtract(const Duration(days: 38)), // 38天前
      now.subtract(const Duration(days: 52)), // 52天前
      now.subtract(const Duration(days: 67)), // 67天前
      now.subtract(const Duration(days: 82)), // 82天前
      now.subtract(const Duration(days: 100)), // 100天前
      now.subtract(const Duration(days: 120)), // 120天前
      now.subtract(const Duration(days: 140)), // 140天前
    ];

    // 为这些日期添加阅读数据
    for (final day in sporadicDays) {
      if (day.isAfter(startDate) || day.isAtSameMomentAs(startDate)) {
        _readingData.add(DateHeatmapCell(
          date: day,
          value: 15 + (day.day % 30).toDouble(), // 随机但不太大的值
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 渐变背景
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFC3E8FF), // 顶部蓝色
            Color(0xFFECF7FE), // 中间浅蓝
            Color(0xFFFFFFFF), // 底部白色
          ],
          stops: [0.0, 0.25, 0.97],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            _buildTopBar(),
            // 上半部分内容 - 可滚动
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      // 书籍封面
                      _buildBookCover(),
                      const SizedBox(height: 20),
                      // 书名
                      const Text(
                        '非暴力沟通',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22242C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // 标签行
                      _buildTagsRow(),
                      const SizedBox(height: 24),
                      // 文件信息
                      _buildFileInfo(),
                      const SizedBox(height: 24),
                      // 统计数据
                      _buildStatistics(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            // 底部固定区域 - 热力图和按钮
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  /// 顶部导航栏
  Widget _buildTopBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xFF1D1B20),
            ),
          ),
          const Spacer(),
          // 更多按钮
          const Icon(
            Icons.more_horiz,
            size: 24,
            color: Color(0xFF1D1B20),
          ),
        ],
      ),
    );
  }

  /// 书籍封面（用色块代替）
  Widget _buildBookCover() {
    return Center(
      child: Container(
        width: 151,
        height: 211,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFBFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFC6CEDF),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 内部装饰色块
            Center(
              child: Container(
                width: 104,
                height: 136,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF1F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Icon(
                    Icons.book,
                    size: 48,
                    color: Color(0xFF9FABBC),
                  ),
                ),
              ),
            ),
            // SMB 标签
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9DEE5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SMB',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF54586A),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 标签行
  Widget _buildTagsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // WebDAV 标签
        _buildTag(
          label: 'WebDAV',
          backgroundColor: const Color(0xFFD9DEE5),
          textColor: const Color(0xFF54586A),
        ),
        const SizedBox(width: 8),
        // 已缓存标签
        _buildTag(
          label: '已缓存',
          backgroundColor: const Color(0xFF32BE76),
          textColor: Colors.white,
        ),
        const SizedBox(width: 8),
        // 已读 80% 标签
        _buildTag(
          label: '已读 80%',
          backgroundColor: const Color(0xFFFFEAD1),
          textColor: const Color(0xFFFF8C00),
        ),
      ],
    );
  }

  Widget _buildTag({
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  /// 文件信息
  Widget _buildFileInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('位置:', '/192.168.31.252/book/非暴力沟通.pdf'),
          const SizedBox(height: 8),
          _buildInfoRow('文件大小:', '12.6 MB'),
          const SizedBox(height: 8),
          _buildInfoRow('添加日期:', '2025/08/03 19:52'),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildInfoRow('格式:', 'pdf'),
              const SizedBox(width: 16),
              _buildInfoRow('类型:', '漫画'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFA7B0C3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFA7B0C3),
          ),
        ),
      ],
    );
  }

  /// 统计数据
  Widget _buildStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(label: '今日阅读时长', value: '36', unit: 'min'),
        _buildStatItem(label: '总阅读时长', value: '36', unit: 'min'),
        _buildStatItem(label: '已读轮次', value: '1', unit: '次'),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required String unit,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF5F6679),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF22242C),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                unit,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF54586A),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 底部区域 - 热力图和按钮
  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 热力图 - 无背景、无标题、无图例、占满宽度
          HeatmapGrid.githubStyle(
            dateData: _readingData,
            colorMapping: const ColorMapping.github(),
            showMonthLabels: false,
            showRowLabels: false,
            showLegend: false,
            scrollable: false,
            onCellTap: (cell) {
              final date = cell.data as DateTime;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '阅读日期: ${date.year}-${date.month}-${date.day}',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            tooltipBuilder: (cell) {
              final date = cell.data as DateTime;
              return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            },
          ),
          const SizedBox(height: 16),
          // 底部按钮
          _buildBottomButtons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// 底部按钮
  Widget _buildBottomButtons() {
    return Row(
      children: [
        // 左滑提示
        const Expanded(
          child: Text(
            '←左滑开始阅读',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFA7B0C3),
            ),
          ),
        ),
        // 跳至最新进度按钮
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFC6CEDF),
              width: 2,
            ),
          ),
          child: const Text(
            '跳至最新进度',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF54586A),
            ),
          ),
        ),
      ],
    );
  }
}
