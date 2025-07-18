class DashboardErrorModel {
  List<StatsError>? data;

  DashboardErrorModel({this.data});

  DashboardErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StatsError>[];
      json['data'].forEach((v) {
        data!.add(new StatsError.fromJson(v));
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

class StatsError {
  int? count;
  String? errorCode;
  double? percentage;

  StatsError({this.count, this.errorCode, this.percentage});

  StatsError.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    errorCode = json['error_code'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['error_code'] = this.errorCode;
    data['percentage'] = this.percentage;
    return data;
  }
}
