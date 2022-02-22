class Channel {
  List<Data> data;

  Channel({this.data});

  Channel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String link;
  String video;
  String audio;
  String description;
  String sId;
  String title;
  String mediaType;
  String image;
  String userId;
  String time;
  String channelId;
  String createdAt;
  String updatedAt;
  int iV;
  Users users;
  String id;

  Data(
      {this.link,
        this.video,
        this.audio,
        this.description,
        this.sId,
        this.title,
        this.mediaType,
        this.image,
        this.userId,
        this.time,
        this.channelId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.users,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    video = json['video'];
    audio = json['audio'];
    description = json['description'];
    sId = json['_id'];
    title = json['title'];
    mediaType = json['media_type'];
    image = json['image'];
    userId = json['userId'];
    time = json['time'];
    channelId = json['channelId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['video'] = this.video;
    data['audio'] = this.audio;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['media_type'] = this.mediaType;
    data['image'] = this.image;
    data['userId'] = this.userId;
    data['time'] = this.time;
    data['channelId'] = this.channelId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Users {
  String stripeSubscription;
  String stripePayment;
  String stripeCustomer;
  String userType;
  String address;
  String long;
  String lat;
  String planStart;
  String planExpired;
  String premiumPlan;
  String otp;
  String bio;
  String gender;
  String profile;
  String fcmToken;
  bool isBackgroundMusic;
  bool isSharedProfile;
  bool isNotification;
  bool status;
  String socialId;
  String email;
  String sId;
  String type;
  String personType;
  String categoryId;
  String fullName;
  String password;
  String updatedAt;
  String createdAt;
  int iV;

  Users(
      {this.stripeSubscription,
        this.stripePayment,
        this.stripeCustomer,
        this.userType,
        this.address,
        this.long,
        this.lat,
        this.planStart,
        this.planExpired,
        this.premiumPlan,
        this.otp,
        this.bio,
        this.gender,
        this.profile,
        this.fcmToken,
        this.isBackgroundMusic,
        this.isSharedProfile,
        this.isNotification,
        this.status,
        this.socialId,
        this.email,
        this.sId,
        this.type,
        this.personType,
        this.categoryId,
        this.fullName,
        this.password,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Users.fromJson(Map<String, dynamic> json) {
    stripeSubscription = json['stripe_subscription'];
    stripePayment = json['stripe_payment'];
    stripeCustomer = json['stripe_customer'];
    userType = json['userType'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    planStart = json['plan_start'];
    planExpired = json['plan_expired'];
    premiumPlan = json['premium_plan'];
    otp = json['otp'];
    bio = json['bio'];
    gender = json['gender'];
    profile = json['profile'];
    fcmToken = json['fcm_token'];
    isBackgroundMusic = json['is_background_music'];
    isSharedProfile = json['is_shared_profile'];
    isNotification = json['is_notification'];
    status = json['status'];
    socialId = json['social_id'];
    email = json['email'];
    sId = json['_id'];
    type = json['type'];
    personType = json['person_type'];
    categoryId = json['category_id'];
    fullName = json['full_name'];
    password = json['password'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stripe_subscription'] = this.stripeSubscription;
    data['stripe_payment'] = this.stripePayment;
    data['stripe_customer'] = this.stripeCustomer;
    data['userType'] = this.userType;
    data['address'] = this.address;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['plan_start'] = this.planStart;
    data['plan_expired'] = this.planExpired;
    data['premium_plan'] = this.premiumPlan;
    data['otp'] = this.otp;
    data['bio'] = this.bio;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['fcm_token'] = this.fcmToken;
    data['is_background_music'] = this.isBackgroundMusic;
    data['is_shared_profile'] = this.isSharedProfile;
    data['is_notification'] = this.isNotification;
    data['status'] = this.status;
    data['social_id'] = this.socialId;
    data['email'] = this.email;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['person_type'] = this.personType;
    data['category_id'] = this.categoryId;
    data['full_name'] = this.fullName;
    data['password'] = this.password;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
