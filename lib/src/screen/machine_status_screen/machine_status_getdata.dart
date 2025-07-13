import 'package:my_app/core/model/machine_status_model.dart';

import '../../data_mau/data_mau.dart';

class MachineStatusGetData {
  Future getMachineStatus() async {
    dynamic result;
    //call api;
    result = api_machine_status;
    if (result != null) {
      return ListMachineStatusModel.fromJson(result);
    }
    return;
  }

  getUniqueSortedLines(List<MachineStatusModel> machines) {
    final lines = machines.map((m) => m.line!).toSet().toList();
    lines.sort(); // sắp xếp theo alphabet
    return lines;
  }

  getUniqueSortedLocations(List<MachineStatusModel> machines) {
    final locations = machines.map((m) => m.location!).toSet().toList();

    // Chuyển về số để sort theo giá trị (không phải chuỗi)
    locations.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    return locations;
  }
}
