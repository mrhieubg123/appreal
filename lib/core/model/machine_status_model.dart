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
  String? status;
  String? error_code;

  MachineStatusModel({
    this.line,
    this.location,
    this.machineName,
    this.status,
    this.error_code,
  });

  MachineStatusModel.fromJson(Map<String, dynamic> json) {
    line = json['LINE'] ?? "";
    location = json['LOCATION'] ?? "";
    machineName = json['MACHINE_NAME'];
    status = json['STATUS'];
    error_code = json['ERROR_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LINE'] = line;
    data['LOCATION'] = location;
    data['MACHINE_NAME'] = machineName;
    data['STATUS'] = status;
    data['ERROR_CODE'] = error_code;
    return data;
  }
}
