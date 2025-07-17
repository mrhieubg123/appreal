class ListErrorNotConfirmModel {
  int? count;
  List<ErrorNotConfirmModel>? data;

  ListErrorNotConfirmModel({this.count, this.data});

  ListErrorNotConfirmModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <ErrorNotConfirmModel>[];
      json['data'].forEach((v) {
        data!.add(new ErrorNotConfirmModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
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
    eRRORCODE = json['ERROR_CODE'];
    eRRORTYPE = json['ERROR_TYPE'];
    iD = json['ID'];
    lINE = json['LINE'];
    lOCATION = json['LOCATION'];
    mACHINENAME = json['MACHINE_NAME'];
    mACHINETYPE = json['MACHINE_TYPE'];
    sTARTTIME = json['START_TIME'];
    sTATUS = json['STATUS'];
    tIME = json['TIME'];
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
