import 'package:flutter/cupertino.dart';

class Video {
  final String id;
  final String title;
  final String thumbnail;
  final String channel;

  Video(
      {@required this.id,
      @required this.title,
      @required this.thumbnail,
      @required this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id'))
      return Video(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        thumbnail: json['snippet']['thumbnails']['high']['url'],
        channel: json['snippet']['channelTitle'],
      );
    else
      return Video(
          id: json['id'],
          channel: json['channel'],
          title: json['title'],
          thumbnail: json['thumb']);
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': id,
      'title': title,
      'thumbnail': thumbnail,
      'channel': channel
    };
  }
}
