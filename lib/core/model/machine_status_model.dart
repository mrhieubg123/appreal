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

  MachineStatusModel({this.line, this.location, this.machineName, this.status});

  MachineStatusModel.fromJson(Map<String, dynamic> json) {
    line = json['line'] ?? "";
    location = json['location'] ?? "";
    machineName = json['machine_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line'] = line;
    data['location'] = location;
    data['machine_name'] = machineName;
    data['status'] = status;
    return data;
  }
}
