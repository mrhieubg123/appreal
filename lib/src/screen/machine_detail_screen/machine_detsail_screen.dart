import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MachineDetailScreen extends StatelessWidget {
  const MachineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double errorPercent = 25; // 25% lỗi
    final double okPercent = 75; // 75% OK

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin máy móc"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Thông tin máy
            const Text(
              "MÁY CẮT CNC SỐ 1",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 6),
                Text("Trạng thái: Đang hoạt động",
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Số giờ hoạt động: 1,254h",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text("Tỷ lệ lỗi tổng thể:", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 24),

            // ✅ Biểu đồ tròn
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      color: Colors.redAccent,
                      value: errorPercent,
                      title: "${errorPercent.toInt()}%",
                      radius: 60,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: okPercent,
                      title: "${okPercent.toInt()}%",
                      radius: 60,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            // ✅ Ghi chú
            const Row(
              children: [
                IndicatorDot(color: Colors.redAccent, label: "Lỗi"),
                SizedBox(width: 16),
                IndicatorDot(color: Colors.green, label: "Hoạt động OK"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final Color color;
  final String label;

  const IndicatorDot({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
