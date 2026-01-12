class PowerHistoryData {
  final String label;
  final double generatedEnergy;
  final double selfConsumption;
  final double powerUsage;

  PowerHistoryData({
    required this.label,
    required this.generatedEnergy,
    required this.selfConsumption,
    required this.powerUsage,
  });
}


List<PowerHistoryData> getMockHistoryData() {
  return [
    PowerHistoryData(label: "10:00", generatedEnergy: 0.5, selfConsumption: 0.4, powerUsage: 0.6),
    PowerHistoryData(label: "11:00", generatedEnergy: 0.8, selfConsumption: 0.6, powerUsage: 0.9),
    PowerHistoryData(label: "12:00", generatedEnergy: 1.2, selfConsumption: 0.8, powerUsage: 1.1),
    PowerHistoryData(label: "13:00", generatedEnergy: 1.5, selfConsumption: 1.0, powerUsage: 1.4),
    PowerHistoryData(label: "14:00", generatedEnergy: 0.9, selfConsumption: 0.7, powerUsage: 1.0),
    PowerHistoryData(label: "15:00", generatedEnergy: 0.6, selfConsumption: 0.5, powerUsage: 0.8),
  ];
}