class ListErrorDetailsModel {
  List<ErrorDetailsModel>? data;

  ListErrorDetailsModel({this.data});

  ListErrorDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ErrorDetailsModel>[];
      json['data'].forEach((v) {
        data!.add(new ErrorDetailsModel.fromJson(v));
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

class ErrorDetailsModel {
  String? error;
  String? errorCode;
  List<ListCause>? listCause;

  ErrorDetailsModel({this.error, this.errorCode, this.listCause});

  ErrorDetailsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorCode = json['error_code'];
    if (json['list_cause'] != null) {
      listCause = <ListCause>[];
      json['list_cause'].forEach((v) {
        listCause!.add(new ListCause.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_code'] = this.errorCode;
    if (this.listCause != null) {
      data['list_cause'] = this.listCause!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListCause {
  String? cause;
  int? idCause;
  int? countWeek;
  int? countMonth;
  List<ListSolution>? listSolution;
  List<String>? solutions;
  List<int>? listCount;

  ListCause({
    this.cause,
    this.idCause,
    this.listSolution,
    this.solutions,
    this.listCount,
    this.countWeek,
    this.countMonth,
  });

  ListCause.fromJson(Map<String, dynamic> json) {
    cause = json['cause'];
    idCause = json['id_cause'];
    countWeek = json['count_week'];
    countMonth = json['count_month'];
    if (json['list_solution'] != null) {
      listSolution = <ListSolution>[];
      json['list_solution'].forEach((v) {
        listSolution!.add(new ListSolution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cause'] = this.cause;
    data['id_cause'] = this.idCause;
    data['count_week'] = this.countWeek;
    data['count_month'] = this.countMonth;
    if (this.listSolution != null) {
      data['list_solution'] = this.listSolution!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ListSolution {
  int? idSolution;
  int? count_month_solution;
  int? count_week_solution;
  String? solution;

  ListSolution({
    this.idSolution,
    this.solution,
    this.count_week_solution,
    this.count_month_solution,
  });

  ListSolution.fromJson(Map<String, dynamic> json) {
    idSolution = json['id_solution'];
    solution = json['solution'];
    count_week_solution = json['count_week_solution'];
    count_month_solution = json['count_month_solution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_solution'] = this.idSolution;
    data['solution'] = this.solution;
    data['count_week_solution'] = this.count_week_solution;
    data['count_month_solution'] = this.count_month_solution;
    return data;
  }
}
