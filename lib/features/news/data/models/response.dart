import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ResponseAPI {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "totalResults")
  final int? totalResults;
  @JsonKey(name: "articles")
  final List<Articles>? articles;

  ResponseAPI ({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ResponseAPI.fromJson(Map<String, dynamic> json) {
    return _$ResponseAPIFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResponseAPIToJson(this);
  }
}

@JsonSerializable()
class Articles {
  @JsonKey(name: "source")
  final Source? source;
  @JsonKey(name: "author")
  final String? author;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "urlToImage")
  final dynamic? urlToImage;
  @JsonKey(name: "publishedAt")
  final String? publishedAt;
  @JsonKey(name: "content")
  final String? content;

  Articles ({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return _$ArticlesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ArticlesToJson(this);
  }
}

@JsonSerializable()
class Source {
  @JsonKey(name: "id")
  final dynamic? id;
  @JsonKey(name: "name")
  final String? name;

  Source ({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return _$SourceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SourceToJson(this);
  }
}


