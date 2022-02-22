/// statusCode : 200
/// message : "Page details successful."
/// data : {"_id":"609181e1c1e0cd39707bdec2","title":"Privacy Policy ","description":"<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p><p><br>&nbsp;</p>","last_userId":"607d35c76e485234103a69d8","createdAt":"2021-05-04T17:18:25.217Z","updatedAt":"2021-05-04T17:18:25.217Z","__v":0}

class HtmlPage {
  int _statusCode;
  String _message;
  Data _data;

  int get statusCode => _statusCode;
  String get message => _message;
  Data get data => _data;

  HtmlPage({
      int statusCode, 
      String message, 
      Data data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  HtmlPage.fromJson(dynamic json) {
    _statusCode = json["statusCode"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["statusCode"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// _id : "609181e1c1e0cd39707bdec2"
/// title : "Privacy Policy "
/// description : "<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p><p><br>&nbsp;</p>"
/// last_userId : "607d35c76e485234103a69d8"
/// createdAt : "2021-05-04T17:18:25.217Z"
/// updatedAt : "2021-05-04T17:18:25.217Z"
/// __v : 0

class Data {
  String _id;
  String _title;
  String _description;
  String _lastUserId;
  String _createdAt;
  String _updatedAt;
  int _v;

  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get lastUserId => _lastUserId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get v => _v;

  Data({
      String id, 
      String title, 
      String description, 
      String lastUserId, 
      String createdAt, 
      String updatedAt, 
      int v}){
    _id = id;
    _title = title;
    _description = description;
    _lastUserId = lastUserId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json["_id"];
    _title = json["title"];
    _description = json["description"];
    _lastUserId = json["last_userId"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["title"] = _title;
    map["description"] = _description;
    map["last_userId"] = _lastUserId;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["__v"] = _v;
    return map;
  }

}