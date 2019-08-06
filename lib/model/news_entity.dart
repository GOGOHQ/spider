class newsEntity {
  final String title;
  final String url;
  final String detailWords;
  final String time;
  newsEntity({this.detailWords, this.time, this.title, this.url});

  factory newsEntity.fromJson(Map<String, dynamic> json) {
    String title = json['title'];
    String url = json['url'];
    String detailWords = json['detailWords'];
    String time = json['time'];
    return new newsEntity(
        detailWords: detailWords, time: time, title: title, url: url);
  }
  Map<String,dynamic> toJson(){
    return {
      'title':title,
      'detailWords':detailWords,
      'url':url,
      'time':time,
    };
  }
  }