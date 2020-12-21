import 'dart:convert';

import 'package:flutter/material.dart';

HostConfig hostConfigFromJson(String str) =>
    HostConfig.fromJson(json.decode(str));

String hostConfigToJson(HostConfig data) => json.encode(data.toJson());

class HostConfig {
  HostConfig({
    this.baseUri,
    this.flutterChannel,
    this.host,
    this.port,
    this.url,
    this.urlNative,
    this.githash,
    this.releaseChannel,
  });

  String baseUri;
  String flutterChannel;
  String host;
  String port;
  String url;
  String urlNative;
  String githash;
  String releaseChannel;

  factory HostConfig.fromJson(Map<String, dynamic> json) => HostConfig(
        baseUri: json["baseUri"],
        flutterChannel: json["flutter_channel"],
        host: json["host"],
        port: json["port"],
        url: json["url"],
        urlNative: json["url_native"],
        githash: json['githash'],
        releaseChannel: json['releaseChannel'],
      );

  factory HostConfig.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return HostConfig.fromJson(json);
  }

  factory HostConfig.empty() => HostConfig(
        baseUri: "",
        flutterChannel: "",
        host: "",
        port: "",
        url: "",
        urlNative: "",
        githash: "",
        releaseChannel: "",
      );

  Map<String, dynamic> toJson() => {
        "baseUri": baseUri,
        "flutter_channel": flutterChannel,
        "host": host,
        "port": port,
        "url": url,
        "url_native": urlNative,
        "githash": githash,
        "releaseChannel": releaseChannel,
      };

}
