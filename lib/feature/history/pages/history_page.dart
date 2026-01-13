import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/mock/history_mock_data.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

enum DisplayType { hourly, daily, monthly }

class HistoryPage extends StatefulWidget {
  final String facilityName;
  final String facilityId;
  final List<PowerHistoryData> initialHourlyData;
  final List<PowerHistoryData> initialDailyData;
  final List<PowerHistoryData> initialMonthlyData;

  const HistoryPage({
    super.key,
    required this.facilityName,
    required this.facilityId,
    required this.initialHourlyData,
    required this.initialDailyData,
    required this.initialMonthlyData,
  });


  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // State variables
  late List<PowerHistoryData> _currentData;
  DisplayType _selectedDisplayType = DisplayType.hourly;
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedMonth;
  DateTime? _startMonth;
  DateTime? _endMonth;
  int _selectedBarIndex = -1;
  bool _showTooltip = false;
  bool _showCalendarPanel = false;
  String _facilityId = "";

  // Date formatters
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  final DateFormat _monthFormat = DateFormat('yyyy/MM');


  final FlutterSecureStorage storage = FlutterSecureStorage();


  Future<void> getFacilityId() async {
    try {
      String? id = await storage.read(key: 'facilityId');
      print("========================================= $id");

      if (id != null && id.isNotEmpty) {
        setState(() {
          _facilityId = id;
        });
        print('FacilitySearch ID found: $id');
      } else {
        setState(() {
          _facilityId = widget.facilityId;
        });
        print('Using widget facility ID: ${widget.facilityId}');
      }
    } catch (e) {
      print('Error reading facilityId: $e');
      setState(() {
        _facilityId = widget.facilityId;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFacilityId();
    _currentData = widget.initialHourlyData;
    _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _startMonth = DateTime(DateTime.now().year, 1);
    _endMonth = DateTime(DateTime.now().year, 12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("施設名_電力量履歴",
                    style:TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),),
                  Text("電力量履歴",
                    style: TextStyle(
                        color: Colors.blue[500]
                    ),)
                ],
              ),
              _buildDisplayTypeSection(),

              _buildDateSelectionSection(),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildGraphArea(),
                ),
              ),

              _buildLegend(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              '${widget.facilityName} - Electricity Usage history',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayTypeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item #2: Display type label
          Text(
            '表示種別',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red[900],
            ),
          ),
          const SizedBox(height: 5),

          Row(
            children: [

              _buildDisplayTypeRadio(
                type: DisplayType.hourly,
                label: '時間帯別',
              ),
              const SizedBox(width: 5 ),


              _buildDisplayTypeRadio(
                type: DisplayType.daily,
                label: '日別',
              ),
              const SizedBox(width: 12),


              _buildDisplayTypeRadio(
                type: DisplayType.monthly,
                label: '月別',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayTypeRadio({
    required DisplayType type,
    required String label,

  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDisplayType = type;
          _selectedBarIndex = -1;
          _showTooltip = false;
          switch (type) {
            case DisplayType.hourly:
              _currentData = widget.initialHourlyData;
              break;
            case DisplayType.daily:
              _currentData = widget.initialDailyData;
              break;
            case DisplayType.monthly:
              _currentData = widget.initialMonthlyData;
              break;
          }
        });
      },
      child: Container(
        height: 30,
        width: 110,
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _selectedDisplayType == type ? Colors.red : Colors.grey[300]!,
            width: _selectedDisplayType == type ? 2 : 1,
          ),
          color: _selectedDisplayType == type ? Colors.white : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedDisplayType == type ? Colors.red : Colors.grey,
                  width: 2,
                ),
                color: _selectedDisplayType == type ? Colors.white : Colors.white,
              ),
              child: _selectedDisplayType == type
                  ? const Icon(Icons.circle, size: 8, color: Colors.red)
                  : null,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: _selectedDisplayType == type
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _selectedDisplayType == type ? Colors.red : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelectionSection() {
    if (_selectedDisplayType == DisplayType.hourly) {
      return _buildHourlyDateSelection();
    } else if (_selectedDisplayType == DisplayType.daily) {
      return _buildMonthlySelection();
    } else {
      return _buildMonthlyRangeSelection();
    }
  }

  Widget _buildHourlyDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item #6: Date selection label
        const Text(
          '日付選択',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 9),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red[900]!, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                  children: [ IconButton(
                    icon:  Icon(Icons.calendar_month, size: 28, color: Colors.red[900],),
                    onPressed: () {
                      setState(() {
                        _showCalendarPanel = !_showCalendarPanel;
                      });
                    },
                  ),
                    Text(
                      _dateFormat.format(_selectedDate),
                      style: const TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ]
              ),


            ),
            SizedBox(width: 30,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red[900],
                  padding: const EdgeInsets.symmetric(
                    // vertical: 1,
                    horizontal: 35,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedBarIndex = -1;
                    _showTooltip = false;
                  });
                },
                child: Text("検索",
                  style: TextStyle(
                      fontSize: 16
                  ),
                )),
          ],
        ),

        // Calendar panel (shown when icon is pressed)
        if (_showCalendarPanel)
          _buildCalendarPanel(),
      ],
    );
  }

  Widget _buildMonthlySelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '月選択',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 50, left: 10, ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red[900]!, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                    children: [ PopupMenuButton<String>(
                      icon: Icon(Icons.calendar_month, size: 25, color: Colors.red[900],),
                      onSelected: (String value) {
                        final parts = value.split('-');
                        setState(() {
                          _selectedMonth = DateTime(int.parse(parts[0]), int.parse(parts[1]));
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        final now = DateTime.now();
                        final List<PopupMenuEntry<String>> items = [];


                        for (int i = 11; i >= 0; i--) {
                          final date = DateTime(now.year, now.month - i);
                          final value = '${date.year}-${date.month}';
                          final display = _monthFormat.format(date);

                          items.add(PopupMenuItem(
                            value: value,
                            child: Text(display),
                          ));
                        }

                        return items;
                      },
                    ),
                      SizedBox(width: 30,),
                      Text(
                        _selectedMonth != null
                            ? _monthFormat.format(_selectedMonth!)
                            : 'Select month',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ]
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[900],
                    padding: const EdgeInsets.symmetric(
                      // vertical: 1,
                      horizontal: 35,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedBarIndex = -1;
                      _showTooltip = false;
                    });
                  },
                  child: Text("検索",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  )),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyRangeSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text("開始日", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),),
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(right: 20,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey!, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                        children: [ IconButton(
                          icon: const Icon(Icons.calendar_month, size: 20),
                          onPressed: () {
                          },
                        ),
                          Text(
                            _startMonth != null
                                ? _monthFormat.format(_startMonth!)
                                : 'YYYY/MM',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ]
                    ),
                  ),
                ],
              ),

            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("開始日", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),),
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(right: 20,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey!, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                        children: [ IconButton(
                          icon: const Icon(Icons.calendar_month, size: 20),
                          onPressed: () {
                          },
                        ),
                          Text(
                            _endMonth != null
                                ? _monthFormat.format(_endMonth!)
                                : 'YYYY/MM',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ]
                    ),
                  ),
                ],
              ),

            ],
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red[900],
                padding: const EdgeInsets.symmetric(
                  // vertical: 1,
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedBarIndex = -1;
                  _showTooltip = false;
                });
              },
              child: Text("検索",
                style: TextStyle(
                    fontSize: 14
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCalendarPanel() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red[900]!),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now(),
        focusedDay: _selectedDate,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
            _showCalendarPanel = false;
          });
        },
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {

            setState(() {
              _selectedBarIndex = -1;
              _showTooltip = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Search',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildGraphArea() {
    if (_currentData.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 16),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: _currentData.length * 60.0,
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _getMaxValue() * 1.2,
                  minY: 0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      if (response != null && response.spot != null) {
                        setState(() {
                          _selectedBarIndex = response.spot!.touchedBarGroupIndex;
                          _showTooltip = true;
                        });
                      }
                    },
                    touchTooltipData: BarTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final item = _currentData[group.x.toInt()];
                        String label;
                        double value;

                        if (rodIndex == 0) {
                          label = 'Generated';
                          value = item.generatedEnergy;
                        } else if (rodIndex == 1) {
                          label = 'Home Cons.';
                          value = item.selfConsumption;
                        } else {
                          label = 'Usage';
                          value = item.powerUsage;
                        }

                        return BarTooltipItem(
                          '$label: ${value.toStringAsFixed(1)} kWh\n${item.label}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < _currentData.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _currentData[index].label,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _selectedBarIndex == index
                                      ? Colors.blue
                                      : Colors.grey[600],
                                  fontWeight: _selectedBarIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 10 == 0) {
                            return Text(
                              '${value.toInt()}',
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[200],
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  barGroups: _buildBarGroups(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return _currentData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final isSelected = _selectedBarIndex == index;
      final barWidth = 8.0;

      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: item.generatedEnergy,
            width: barWidth,
            color: isSelected ? Colors.green[400]! : Colors.green,
            borderRadius: BorderRadius.circular(2),
          ),
          BarChartRodData(
            toY: item.selfConsumption,
            width: barWidth,
            color: isSelected ? Colors.orange[400]! : Colors.red,
            borderRadius: BorderRadius.circular(2),
          ),
          BarChartRodData(
            toY: item.powerUsage,
            width: barWidth,
            color: isSelected ? Colors.blue[400]! : Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildLegend() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem(Colors.green),
              const SizedBox(height: 6),
              _legendItem(Colors.red),
              const SizedBox(height: 6),
              _legendItem(Colors.blue),
            ],
          ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.consumption, arguments: _facilityId);
                },
                child: Text("電力量現在値確認")),
          ]
      ),
    );
  }

  Widget _legendItem(Color color) {
    return
        Container(
          width: 120,
          height: 10,
          color: color,
    );
  }

  double _getMaxValue() {
    if (_currentData.isEmpty) return 50.0;
    double max = 0;
    for (var item in _currentData) {
      max = [max, item.generatedEnergy, item.selfConsumption, item.powerUsage]
          .reduce((a, b) => a > b ? a : b);
    }
    return max;
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
