class ErrorDetailTotalModel {
  List<ErrorCauseSolutionModel>? data;

  ErrorDetailTotalModel({this.data});

  ErrorDetailTotalModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ErrorCauseSolutionModel>[];
      json['data'].forEach((v) {
        data!.add(ErrorCauseSolutionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErrorCauseSolutionModel {
  String? cause;
  int? errorId;
  String? errorName;
  String? solution;
  int? usedCount;

  ErrorCauseSolutionModel(
      {this.cause,
        this.errorId,
        this.errorName,
        this.solution,
        this.usedCount});

  ErrorCauseSolutionModel.fromJson(Map<String, dynamic> json) {
    cause = json['cause'];
    errorId = json['error_id'];
    errorName = json['error_name'];
    solution = json['solution'];
    usedCount = json['used_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cause'] = this.cause;
    data['error_id'] = this.errorId;
    data['error_name'] = this.errorName;
    data['solution'] = this.solution;
    data['used_count'] = this.usedCount;
    return data;
  }
}
