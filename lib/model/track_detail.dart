/// description : "<p>test desc charge</p>"
/// _id : "607f1cf684fbab674f705d70"
/// title : "Test charge"
/// status : "PUBLIC"
/// image : "post/1618943222412.jpeg"
/// userId : "607d35c76e485234103a69d8"
/// type : "CHARGE"
/// createdAt : "2021-04-20T18:27:02.415Z"
/// updatedAt : "2021-04-20T18:43:59.348Z"
/// __v : 0
/// users : {"gender":"Male","profile":"","fcm_token":"N/A","is_background_music":true,"is_shared_profile":true,"is_notification":true,"status":true,"social_id":"false","email":"test@gmail.com","_id":"607d35c76e485234103a69d8","type":"App","person_type":"Morning","category_id":"60393ef9434d43160ce01156","full_name":"Test Admin","password":"$2b$10$XWs5kSMdEsB78vaXYD1VQu1zmieQpJDvYr9j3EXbEJACaSFiuyDDC","updated_at":"2021-04-19T07:48:23.717Z","created_at":"2021-04-19T07:48:23.717Z","__v":0}
/// playlists : [{"description":"<p>test track2</p>","_id":"607f1cfa84fbab674f705d71","title":"test track1","audio":"playlist/1618943226561.mpeg","image":"playlist/1618943226565.png","userId":"607d35c76e485234103a69d8","time":"5:00","postId":"607f1cf684fbab674f705d70","createdAt":"2021-04-20T18:27:06.570Z","updatedAt":"2021-04-20T18:27:06.570Z","__v":0,"id":"607f1cfa84fbab674f705d71"}]
/// id : "607f1cf684fbab674f705d70"

class TrackDetail {
  String _description;
  String _id;
  String _title;
  String _status;
  String _image;
  String _userId;
  String _type;
  String _createdAt;
  String _updatedAt;
  int _v;
  Users _users;
  List<Playlists> _playlists;
  List<Favorites> _favorites;

  String get description => _description;
  String get id => _id;
  String get title => _title;
  String get status => _status;
  String get image => _image;
  String get userId => _userId;
  String get type => _type;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get v => _v;
  Users get users => _users;
  List<Playlists> get playlists => _playlists;
  List<Favorites> get favorites => _favorites;

  TrackDetail({
      String description, 
      String id, 
      String title, 
      String status, 
      String image, 
      String userId, 
      String type, 
      String createdAt, 
      String updatedAt, 
      int v, 
      Users users, 
      List<Playlists> playlists, List<Favorites> favorites
      }){
    _description = description;
    _id = id;
    _title = title;
    _status = status;
    _image = image;
    _userId = userId;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _users = users;
    _playlists = playlists;
    _favorites = favorites;
    _id = id;
}

  TrackDetail.fromJson(dynamic json) {
    _description = json["description"];
    _id = json["_id"];
    _title = json["title"];
    _status = json["status"];
    _image = json["image"];
    _userId = json["userId"];
    _type = json["type"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _v = json["__v"];
    _users = json["users"] != null ? Users.fromJson(json["users"]) : null;
    if (json["playlists"] != null) {
      _playlists = [];
      json["playlists"].forEach((v) {
        _playlists.add(Playlists.fromJson(v));
      });
    }

    if (json["favorites"] != null) {
      _favorites = [];
      json["favorites"].forEach((v) {
        _favorites.add(Favorites.fromJson(v));
      });
    }
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = _description;
    map["_id"] = _id;
    map["title"] = _title;
    map["status"] = _status;
    map["image"] = _image;
    map["userId"] = _userId;
    map["type"] = _type;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["__v"] = _v;
    if (_users != null) {
      map["users"] = _users.toJson();
    }
    if (_playlists != null) {
      map["playlists"] = _playlists.map((v) => v.toJson()).toList();
    }
    map["id"] = _id;
    return map;
  }

}

/// description : "<p>test track2</p>"
/// _id : "607f1cfa84fbab674f705d71"
/// title : "test track1"
/// audio : "playlist/1618943226561.mpeg"
/// image : "playlist/1618943226565.png"
/// userId : "607d35c76e485234103a69d8"
/// time : "5:00"
/// postId : "607f1cf684fbab674f705d70"
/// createdAt : "2021-04-20T18:27:06.570Z"
/// updatedAt : "2021-04-20T18:27:06.570Z"
/// __v : 0
/// id : "607f1cfa84fbab674f705d71"

class Playlists {
  String _description;
  String _id;
  String _title;
  String _audio;
  String _image;
  String _userId;
  String _time;
  String _postId;
  String _createdAt;
  String _updatedAt;
  String _mediaType;
  String _video;
  String _link;
  int _v;

  String get description => _description;
  String get id => _id;
  String get title => _title;
  String get audio => _audio;
  String get image => _image;
  String get userId => _userId;
  String get time => _time;
  String get postId => _postId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get mediaType => _mediaType;
  String get video => _video;
  String get link => _link;
  int get v => _v;

  Playlists({
      String description, 
      String id, 
      String title, 
      String audio, 
      String image, 
      String userId, 
      String time, 
      String postId, 
      String createdAt, 
      String updatedAt,
    String mediaType,
    String link,
    String video,
      int v}){
    _description = description;
    _id = id;
    _title = title;
    _audio = audio;
    _image = image;
    _userId = userId;
    _time = time;
    _postId = postId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _mediaType = mediaType;
    _video = video;
    _link = link;
    _v = v;
    _id = id;
}

  Playlists.fromJson(dynamic json) {
    _description = json["description"];
    _id = json["_id"];
    _title = json["title"];
    _audio = json["audio"];
    _image = json["image"];
    _userId = json["userId"];
    _time = json["time"];
    _postId = json["postId"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _mediaType = json["media_type"];

    _link = json["link"];
    _video = json["video"];


    _v = json["__v"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = _description;
    map["_id"] = _id;
    map["title"] = _title;
    map["audio"] = _audio;
    map["image"] = _image;
    map["userId"] = _userId;
    map["time"] = _time;
    map["postId"] = _postId;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["media_type"] = _mediaType;
    map["__v"] = _v;
    map["id"] = _id;
    return map;
  }

}

/// gender : "Male"
/// profile : ""
/// fcm_token : "N/A"
/// is_background_music : true
/// is_shared_profile : true
/// is_notification : true
/// status : true
/// social_id : "false"
/// email : "test@gmail.com"
/// _id : "607d35c76e485234103a69d8"
/// type : "App"
/// person_type : "Morning"
/// category_id : "60393ef9434d43160ce01156"
/// full_name : "Test Admin"
/// password : "$2b$10$XWs5kSMdEsB78vaXYD1VQu1zmieQpJDvYr9j3EXbEJACaSFiuyDDC"
/// updated_at : "2021-04-19T07:48:23.717Z"
/// created_at : "2021-04-19T07:48:23.717Z"
/// __v : 0

class Users {
  String _gender;
  String _profile;
  String _fcmToken;
  bool _isBackgroundMusic;
  bool _isSharedProfile;
  bool _isNotification;
  bool _status;
  String _socialId;
  String _email;
  String _id;
  String _type;
  String _personType;
  String _categoryId;
  String _fullName;
  String _password;
  String _updatedAt;
  String _createdAt;
  int _v;

  String get gender => _gender;
  String get profile => _profile;
  String get fcmToken => _fcmToken;
  bool get isBackgroundMusic => _isBackgroundMusic;
  bool get isSharedProfile => _isSharedProfile;
  bool get isNotification => _isNotification;
  bool get status => _status;
  String get socialId => _socialId;
  String get email => _email;
  String get id => _id;
  String get type => _type;
  String get personType => _personType;
  String get categoryId => _categoryId;
  String get fullName => _fullName;
  String get password => _password;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get v => _v;

  Users({
      String gender, 
      String profile, 
      String fcmToken, 
      bool isBackgroundMusic, 
      bool isSharedProfile, 
      bool isNotification, 
      bool status, 
      String socialId, 
      String email, 
      String id, 
      String type, 
      String personType, 
      String categoryId, 
      String fullName, 
      String password, 
      String updatedAt, 
      String createdAt, 
      int v}){
    _gender = gender;
    _profile = profile;
    _fcmToken = fcmToken;
    _isBackgroundMusic = isBackgroundMusic;
    _isSharedProfile = isSharedProfile;
    _isNotification = isNotification;
    _status = status;
    _socialId = socialId;
    _email = email;
    _id = id;
    _type = type;
    _personType = personType;
    _categoryId = categoryId;
    _fullName = fullName;
    _password = password;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _v = v;
}

  Users.fromJson(dynamic json) {
    _gender = json["gender"];
    _profile = json["profile"];
    _fcmToken = json["fcm_token"];
    _isBackgroundMusic = json["is_background_music"];
    _isSharedProfile = json["is_shared_profile"];
    _isNotification = json["is_notification"];
    _status = json["status"];
    _socialId = json["social_id"];
    _email = json["email"];
    _id = json["_id"];
    _type = json["type"];
    _personType = json["person_type"];
    _categoryId = json["category_id"];
    _fullName = json["full_name"];
    _password = json["password"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["gender"] = _gender;
    map["profile"] = _profile;
    map["fcm_token"] = _fcmToken;
    map["is_background_music"] = _isBackgroundMusic;
    map["is_shared_profile"] = _isSharedProfile;
    map["is_notification"] = _isNotification;
    map["status"] = _status;
    map["social_id"] = _socialId;
    map["email"] = _email;
    map["_id"] = _id;
    map["type"] = _type;
    map["person_type"] = _personType;
    map["category_id"] = _categoryId;
    map["full_name"] = _fullName;
    map["password"] = _password;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["__v"] = _v;
    return map;
  }

}

/// _id : "60915a8b2ef5e23b248c9562"
/// userId : "6085015dcf02b3a68d64bad3"
/// postId : "609025e8e52cd42b5c47a196"
/// createdAt : "2021-05-04T14:30:35.970Z"
/// __v : 0
/// id : "60915a8b2ef5e23b248c9562"

class Favorites {
  String _id;
  String _userId;
  String _postId;
  String _createdAt;
  int _v;

  String get id => _id;
  String get userId => _userId;
  String get postId => _postId;
  String get createdAt => _createdAt;
  int get v => _v;

  Favorites({
    String id,
    String userId,
    String postId,
    String createdAt,
    int v}){
    _id = id;
    _userId = userId;
    _postId = postId;
    _createdAt = createdAt;
    _v = v;
    _id = id;
  }

  Favorites.fromJson(dynamic json) {
    _id = json["_id"];
    _userId = json["userId"];
    _postId = json["postId"];
    _createdAt = json["createdAt"];
    _v = json["__v"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["userId"] = _userId;
    map["postId"] = _postId;
    map["createdAt"] = _createdAt;
    map["__v"] = _v;
    map["id"] = _id;
    return map;
  }

}