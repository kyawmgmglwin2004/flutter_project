import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../mock/history_mock_data.dart';
import '../widgets/day_picker.dart';
import '../widgets/graph_area.dart';
import '../widgets/legend_view.dart';

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
  DisplayType _selectedDisplayType = DisplayType.hourly;
  List<PowerHistoryData> _currentData = [];

  int _selectedBarIndex = -1;
  bool _showTooltip = false;

  @override
  void initState() {
    super.initState();
    _currentData = widget.initialHourlyData;
  }

  void _onDisplayTypeChanged(DisplayType type) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Header
              Text('${widget.facilityName} - Electricity Usage History',
                  style: TextStyle(color: Colors.blue[500], fontSize: 17)),

              const SizedBox(height: 8),

              // Display type selector
              DisplayTypeSelector(
                selectedType: _selectedDisplayType,
                onChanged: _onDisplayTypeChanged,
              ),

              const SizedBox(height: 8),

              // Date picker / month / range picker
              Builder(builder: (context) {
                switch (_selectedDisplayType) {
                  case DisplayType.hourly:
                    return DayPicker();
                  case DisplayType.daily:
                    return MonthlyPicker();
                  case DisplayType.monthly:
                    return MonthlyRangePicker();
                }
              }),

              const SizedBox(height: 8),

              // Graph area
              Expanded(
                child: GraphArea(
                  data: _currentData,
                  selectedIndex: _selectedBarIndex,
                  onBarSelected: (index) {
                    setState(() {
                      _selectedBarIndex = index;
                      _showTooltip = true;
                    });
                  },
                ),
              ),

              // Legend
              LegendWidget(
                facilityId: widget.facilityId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthlyRangePicker {
}

class MonthlyPicker {
}
