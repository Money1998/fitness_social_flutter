import 'package:flutter/material.dart';

/// statusCode : 200
/// message : "Habit listing successful."
/// data : [{"_id":"60e15ad43e9a58f69dcfb3a9","userId":"609151362ef5e23b248c9561","title":"hello","desc":"this is for desc","goals":"[{\"name\":\"option A\",\"status\":\"0\"},{\"name\":\"option B\",\"status\":\"0\"},{\"name\":\"option C\",\"status\":\"0\"},{\"name\":\"option D\",\"status\":\"0\"}]","updatedAt":"2021-07-04T06:53:08.125Z","createdAt":"2021-07-04T06:53:08.125Z","__v":0,"id":"60e15ad43e9a58f69dcfb3a9"}]

class HabitData {

  List<Data> _data = List();

  List<Data> get data => _data;

  HabitData({List<Data> data}) {
    _data = data;
  }

  HabitData.fromJson(dynamic json) {

    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "60e15ad43e9a58f69dcfb3a9"
/// userId : "609151362ef5e23b248c9561"
/// title : "hello"
/// desc : "this is for desc"
/// goals : "[{\"name\":\"option A\",\"status\":\"0\"},{\"name\":\"option B\",\"status\":\"0\"},{\"name\":\"option C\",\"status\":\"0\"},{\"name\":\"option D\",\"status\":\"0\"}]"
/// updatedAt : "2021-07-04T06:53:08.125Z"
/// createdAt : "2021-07-04T06:53:08.125Z"
/// __v : 0
/// id : "60e15ad43e9a58f69dcfb3a9"

class Data {
  String _id;
  String _userId;
  String _title;
  String _desc;
  String _goals;
  String _updatedAt;
  String _createdAt;
  int _v;

  String get id => _id;

  String get userId => _userId;

  String get title => _title;

  String get desc => _desc;

  String get goals => _goals;

  String get updatedAt => _updatedAt;

  String get createdAt => _createdAt;

  int get v => _v;

  Data(
      {String id,
      String userId,
      String title,
      String desc,
      String goals,
      String updatedAt,
      String createdAt,
      int v}) {
    _id = id;
    _userId = userId;
    _title = title;
    _desc = desc;
    _goals = goals;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _v = v;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _id = json["_id"];
    _userId = json["userId"];
    _title = json["title"];
    _desc = json["desc"];
    _goals = json["goals"];
    _updatedAt = json["updatedAt"];
    _createdAt = json["createdAt"];
    _v = json["__v"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["userId"] = _userId;
    map["title"] = _title;
    map["desc"] = _desc;
    map["goals"] = _goals;
    map["updatedAt"] = _updatedAt;
    map["createdAt"] = _createdAt;
    map["__v"] = _v;
    map["id"] = _id;
    return map;
  }
}
