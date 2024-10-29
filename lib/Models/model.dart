class MoodResponse {
  List<Body>? body;
  bool? success;

  MoodResponse({this.body, this.success});

  MoodResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(Body.fromJson(v));
      });
    } else {
      body = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (body != null) {
      data['body'] = body!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Body {
  int? id;
  String? question;
  String? answerType;
  List<Options>? options;

  Body({this.id, this.question, this.answerType, this.options});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answerType = json['answerType'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answerType'] = answerType;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? option;
  bool? isFreeForm;
  int? questionId;

  Options({this.id, this.option, this.isFreeForm, this.questionId});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    option = json['option'];
    isFreeForm = json['isFreeForm'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['option'] = option;
    data['isFreeForm'] = isFreeForm;
    data['questionId'] = questionId;
    return data;
  }
}
