import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});
  @override
  Widget build(BuildContext context) {
   return HeatMap(
    // firebaseden alıcak şekilde değiştirilicek burası datasets firebaseden hayvandan gelmeli veteriner bu bilgiyi yazmalı onun dökümanına gelecek aşıları olucak burda
  datasets: {
    DateTime(2023, 7, 6): 3,
    DateTime(2023, 7, 7): 7,
    DateTime(2023, 7, 8): 10,
    DateTime(2023, 7, 9): 13,
    DateTime(2023, 7, 25): 6,
  },
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 40)),
  colorMode: ColorMode.opacity,
  size: 40,
  textColor: const Color.fromARGB(255, 255, 64, 64),
  showText: false,
  scrollable: true,
  colorsets: {
    1: Colors.red,
    3: Colors.orange,
    5: Colors.yellow,
    7: Colors.green,
    9: Colors.blue,
    11: Colors.indigo,
    13: Colors.purple,
  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
);
  }
}

 