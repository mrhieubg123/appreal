class ErrorStatsModel {
  String? errorCode;
  int? errorCodeErrorsLast30Days;
  int? errorCodeErrorsLast7Days;
  int? totalErrorsLast30Days;
  int? totalErrorsLast7Days;

  ErrorStatsModel(
      {this.errorCode,
        this.errorCodeErrorsLast30Days,
        this.errorCodeErrorsLast7Days,
        this.totalErrorsLast30Days,
        this.totalErrorsLast7Days});

  ErrorStatsModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    errorCodeErrorsLast30Days = json['error_code_errors_last_30_days'];
    errorCodeErrorsLast7Days = json['error_code_errors_last_7_days'];
    totalErrorsLast30Days = json['total_errors_last_30_days'];
    totalErrorsLast7Days = json['total_errors_last_7_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['error_code_errors_last_30_days'] = this.errorCodeErrorsLast30Days;
    data['error_code_errors_last_7_days'] = this.errorCodeErrorsLast7Days;
    data['total_errors_last_30_days'] = this.totalErrorsLast30Days;
    data['total_errors_last_7_days'] = this.totalErrorsLast7Days;
    return data;
  }
}
