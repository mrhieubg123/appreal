class ErrorDetailByCodeModel {
  List<ErrorList>? errorList;
  int? idconfirm;

  ErrorDetailByCodeModel({this.errorList, this.idconfirm});

  ErrorDetailByCodeModel.fromJson(Map<String, dynamic> json) {
    if (json['error_list'] != null) {
      errorList = <ErrorList>[];
      json['error_list'].forEach((v) {
        errorList!.add(new ErrorList.fromJson(v));
      });
    }
    idconfirm = json['idconfirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.errorList != null) {
      data['error_list'] = this.errorList!.map((v) => v.toJson()).toList();
    }
    data['idconfirm'] = this.idconfirm;
    return data;
  }
}

class ErrorList {
  String? cause;
  String? errorCode;
  String? errorName;
  int? id;
  String? solution;

  ErrorList(
      {this.cause, this.errorCode, this.errorName, this.id, this.solution});

  ErrorList.fromJson(Map<String, dynamic> json) {
    cause = json['cause'];
    errorCode = json['error_code'];
    errorName = json['error_name'];
    id = json['id'];
    solution = json['solution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cause'] = this.cause;
    data['error_code'] = this.errorCode;
    data['error_name'] = this.errorName;
    data['id'] = this.id;
    data['solution'] = this.solution;
    return data;
  }
}
