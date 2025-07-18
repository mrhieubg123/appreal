class ListMachineStatusModel {
  List<MachineStatusModel>? data;

  ListMachineStatusModel({this.data});

  ListMachineStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MachineStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MachineStatusModel {
  String? line;
  String? location;
  String? machineName;
  String? machineType;
  String? status;
  String? error_code;

  MachineStatusModel({
    this.line,
    this.location,
    this.machineName,
    this.machineType,
    this.status,
    this.error_code,
  });

  MachineStatusModel.fromJson(Map<String, dynamic> json) {
    line = json['line'] ?? "";
    location = json['location'] ?? "";
    machineName = json['machine_name'];
    machineType = json['machine_type'];
    status = json['status'];
    error_code = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line'] = line;
    data['location'] = location;
    data['machine_name'] = machineName;
    data['machine_type'] = machineType;
    data['status'] = status;
    data['error_code'] = error_code;
    return data;
  }
}
