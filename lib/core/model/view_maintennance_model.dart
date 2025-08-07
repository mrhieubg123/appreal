class ViewMaintenanceModel {
  List<History>? history;
  MachineInfo? machineInfo;

  ViewMaintenanceModel({this.history, this.machineInfo});

  ViewMaintenanceModel.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
    machineInfo = json['machine_info'] != null
        ? MachineInfo.fromJson(json['machine_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    if (machineInfo != null) {
      data['machine_info'] = machineInfo!.toJson();
    }
    return data;
  }
}

class History {
  String? actionTaken;
  String? content;
  String? createdAt;
  String? maintainer;
  String? maintenanceType;
  int? no;
  String? techSpec;

  History(
      {this.actionTaken,
        this.content,
        this.createdAt,
        this.maintainer,
        this.maintenanceType,
        this.no,
        this.techSpec});

  History.fromJson(Map<String, dynamic> json) {
    actionTaken = json['action_taken'];
    content = json['content'];
    createdAt = json['created_at'];
    maintainer = json['maintainer'];
    maintenanceType = json['maintenance_type'];
    no = json['no'];
    techSpec = json['tech_spec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action_taken'] = actionTaken;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['maintainer'] = maintainer;
    data['maintenance_type'] = maintenanceType;
    data['no'] = no;
    data['tech_spec'] = techSpec;
    return data;
  }
}

class MachineInfo {
  String? machineName;

  MachineInfo({this.machineName});

  MachineInfo.fromJson(Map<String, dynamic> json) {
    machineName = json['machine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['machine_name'] = machineName;
    return data;
  }
}
