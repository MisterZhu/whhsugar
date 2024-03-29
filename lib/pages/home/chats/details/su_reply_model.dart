class SUAIReplyModel {
  String? name;
  ReMetadata? metadata;
  bool? done;
  Response? response;

  SUAIReplyModel({this.name, this.metadata, this.done, this.response});

  SUAIReplyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    metadata = json['metadata'] != null
        ? new ReMetadata.fromJson(json['metadata'])
        : null;
    done = json['done'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['done'] = this.done;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class ReMetadata {
  String? type;
  PartialResult? partialResult;

  ReMetadata({this.type, this.partialResult});

  ReMetadata.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    partialResult = json['partialResult'] != null
        ? new PartialResult.fromJson(json['partialResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    if (this.partialResult != null) {
      data['partialResult'] = this.partialResult!.toJson();
    }
    return data;
  }
}

class PartialResult {
  List<ReMessages>? msg;

  PartialResult({this.msg});

  PartialResult.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      msg = <ReMessages>[];
      json['messages'].forEach((v) {
        msg!.add(new ReMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msg != null) {
      data['messages'] = this.msg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReMessages {
  String? author;
  String? name;
  String? createTime;
  // String? labels;
  ReContent? conte;
  String? updateTime;

  ReMessages(
      {this.author,
      this.name,
      this.createTime,
      // this.labels,
      this.conte,
      this.updateTime});

  ReMessages.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    name = json['name'];
    createTime = json['createTime'];
    // labels = json['labels'];
    conte = json['content'] != null
        ? new ReContent.fromJson(json['content'])
        : null;
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['name'] = this.name;
    data['createTime'] = this.createTime;
    // data['labels'] = this.labels;
    if (this.conte != null) {
      data['content'] = this.conte!.toJson();
    }
    data['updateTime'] = this.updateTime;
    return data;
  }
}

class ReContent {
  InlineSource? inlineSource;

  ReContent({this.inlineSource});

  ReContent.fromJson(Map<String, dynamic> json) {
    inlineSource = json['InlineSource'] != null
        ? new InlineSource.fromJson(json['InlineSource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inlineSource != null) {
      data['InlineSource'] = this.inlineSource!.toJson();
    }
    return data;
  }
}

class InlineSource {
  ContentType? contentType;
  String? data;

  InlineSource({this.contentType, this.data});

  InlineSource.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'] != null
        ? new ContentType.fromJson(json['contentType'])
        : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentType != null) {
      data['contentType'] = this.contentType!.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class ContentType {
  dynamic? textPlain;

  ContentType({this.textPlain});

  ContentType.fromJson(Map<String, dynamic> json) {
    textPlain = json['text/plain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text/plain'] = this.textPlain;
    return data;
  }
}

class Response {
  String? type;
  List<String>? messages;
  Metadata? metadata;

  Response({this.type, this.messages, this.metadata});

  Response.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    messages = json['messages'].cast<String>();
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['messages'] = this.messages;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  SafetyMetadata? safetyMetadata;
  TokenMetadata? tokenMetadata;

  Metadata({this.safetyMetadata, this.tokenMetadata});

  Metadata.fromJson(Map<String, dynamic> json) {
    safetyMetadata = json['safetyMetadata'] != null
        ? new SafetyMetadata.fromJson(json['safetyMetadata'])
        : null;
    tokenMetadata = json['tokenMetadata'] != null
        ? new TokenMetadata.fromJson(json['tokenMetadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.safetyMetadata != null) {
      data['safetyMetadata'] = this.safetyMetadata!.toJson();
    }
    if (this.tokenMetadata != null) {
      data['tokenMetadata'] = this.tokenMetadata!.toJson();
    }
    return data;
  }
}

class SafetyMetadata {
  bool? blocked;

  SafetyMetadata({this.blocked});

  SafetyMetadata.fromJson(Map<String, dynamic> json) {
    blocked = json['blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blocked'] = this.blocked;
    return data;
  }
}

class TokenMetadata {
  InputTokenCount? inputTokenCount;
  InputTokenCount? outputTokenCount;

  TokenMetadata({this.inputTokenCount, this.outputTokenCount});

  TokenMetadata.fromJson(Map<String, dynamic> json) {
    inputTokenCount = json['inputTokenCount'] != null
        ? new InputTokenCount.fromJson(json['inputTokenCount'])
        : null;
    outputTokenCount = json['outputTokenCount'] != null
        ? new InputTokenCount.fromJson(json['outputTokenCount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inputTokenCount != null) {
      data['inputTokenCount'] = this.inputTokenCount!.toJson();
    }
    if (this.outputTokenCount != null) {
      data['outputTokenCount'] = this.outputTokenCount!.toJson();
    }
    return data;
  }
}

class InputTokenCount {
  int? totalTokens;

  InputTokenCount({this.totalTokens});

  InputTokenCount.fromJson(Map<String, dynamic> json) {
    totalTokens = json['totalTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalTokens'] = this.totalTokens;
    return data;
  }
}
