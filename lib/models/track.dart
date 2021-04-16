// To parse this JSON data, do
//
//     final track = trackFromJson(jsonString);

import 'dart:convert';

Track trackFromJson(String str) => Track.fromJson(json.decode(str));

String trackToJson(Track data) => json.encode(data.toJson());

class Track {
  Track({
    this.name,
    this.artiest,
    this.style,
    this.albumSource,
    this.time,
  });

  String name;
  String artiest;
  int style;
  String albumSource;
  String time;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        name: json["Name"],
        artiest: json["Artiest"],
        style: json["Style"],
        albumSource: json["AlbumSource"],
        time: json["Time"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Artiest": artiest,
        "Style": style,
        "AlbumSource": albumSource,
        "Time": time,
      };
}
