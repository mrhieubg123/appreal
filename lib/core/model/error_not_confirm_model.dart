class ListErrorNotConfirmModel {
  List<ErrorNotConfirmModel>? data;

  ListErrorNotConfirmModel({this.data});

  ListErrorNotConfirmModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ErrorNotConfirmModel>[];
      json['data'].forEach((v) {
        data!.add(new ErrorNotConfirmModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErrorNotConfirmModel {
  String? eNDTIME;
  String? eRRORCODE;
  String? eRRORTYPE;
  String? error_name;
  int? iD;
  String? lINE;
  String? lOCATION;
  String? mACHINENAME;
  String? mACHINETYPE;
  String? sTARTTIME;
  String? sTATUS;
  int? tIME;
  Null? idConfirm;

  ErrorNotConfirmModel(
      {this.eNDTIME,
        this.eRRORCODE,
        this.eRRORTYPE,
        this.error_name,
        this.iD,
        this.lINE,
        this.lOCATION,
        this.mACHINENAME,
        this.mACHINETYPE,
        this.sTARTTIME,
        this.sTATUS,
        this.tIME,
        this.idConfirm});

  ErrorNotConfirmModel.fromJson(Map<String, dynamic> json) {
    eNDTIME = json['END_TIME'];
    eRRORCODE = json['error_code'];
    eRRORTYPE = json['error_type'];
    error_name = json['error_name'];
    iD = json['id'];
    lINE = json['line'];
    lOCATION = json['location'];
    mACHINENAME = json['machine_name'];
    mACHINETYPE = json['machine_type'];
    sTARTTIME = json['start_time'];
    sTATUS = json['status'];
    tIME = json['runtime_min'];
    idConfirm = json['id_confirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['END_TIME'] = this.eNDTIME;
    data['ERROR_CODE'] = this.eRRORCODE;
    data['ERROR_TYPE'] = this.eRRORTYPE;
    data['ID'] = this.iD;
    data['LINE'] = this.lINE;
    data['LOCATION'] = this.lOCATION;
    data['MACHINE_NAME'] = this.mACHINENAME;
    data['MACHINE_TYPE'] = this.mACHINETYPE;
    data['START_TIME'] = this.sTARTTIME;
    data['STATUS'] = this.sTATUS;
    data['TIME'] = this.tIME;
    data['id_confirm'] = this.idConfirm;
    return data;
  }
}
