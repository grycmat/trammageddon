import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/screens/dashboard/data_box.dart';
import 'package:trammageddon/services/incident.service.dart';

var gitIt = GetIt.I;

class MyAllIncidentsCount extends StatelessWidget {
  const MyAllIncidentsCount({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.get<IncidentService>().getMyIncidentsCount(),
      builder: (_, AsyncSnapshot<int?> snapshot) {
        var value = snapshot.data ?? 0;
        return DataBox(value: value, label: 'WSZYSTKIE');
      },
    );
  }
}
