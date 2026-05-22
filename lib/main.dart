import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Timezone Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ClockScreen(),
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  // 定义不同的时区
  final List<TimeZoneInfo> timeZones = [
    TimeZoneInfo(name: '北京时间 (UTC+8)', offset: 8),
    TimeZoneInfo(name: '伦敦 (UTC+0)', offset: 0),
    TimeZoneInfo(name: '纽约 (UTC-5)', offset: -5),
    TimeZoneInfo(name: '东京 (UTC+9)', offset: 9),
    TimeZoneInfo(name: '悉尼 (UTC+10)', offset: 10),
    TimeZoneInfo(name: '迪拜 (UTC+4)', offset: 4),
    TimeZoneInfo(name: '孟买 (UTC+5:30)', offset: 5.5),
    TimeZoneInfo(name: '洛杉矶 (UTC-8)', offset: -8),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('全球时钟'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.purple.shade900],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 主时钟显示（当前本地时间）
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyan, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '当前时间',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.cyan,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _formatTime(_currentTime),
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Courier',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat('yyyy年 MM月 dd日 EEEE', 'zh_CN')
                          .format(_currentTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[300],
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              // 其他时区时钟列表
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: timeZones.length,
                  itemBuilder: (context, index) {
                    final timezone = timeZones[index];
                    final timeInZone = _currentTime
                        .add(Duration(hours: timezone.offset.toInt()))
                        .add(Duration(
                          minutes:
                              ((timezone.offset % 1) * 60).toInt(),
                        ));

                    return ClockCard(
                      timeZoneName: timezone.name,
                      time: _formatTime(timeInZone),
                      offset: timezone.offset,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }
}

class ClockCard extends StatelessWidget {
  final String timeZoneName;
  final String time;
  final double offset;

  const ClockCard({
    Key? key,
    required this.timeZoneName,
    required this.time,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
        backdropFilter: null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeZoneName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'UTC${offset >= 0 ? '+' : ''}${offset.toStringAsFixed(offset % 1 == 0 ? 0 : 1)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
              fontFamily: 'Courier',
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeZoneInfo {
  final String name;
  final double offset;

  TimeZoneInfo({required this.name, required this.offset});
}
