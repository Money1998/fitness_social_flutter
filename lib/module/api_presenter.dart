import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/RestClient.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/customs/global_var.dart' as globals;
import 'package:montage/model/user_model.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/views/habits/habit_pojo.dart';

class ApiPresenter {
  ApiCallBacks _apiCallBack;

  ApiPresenter(this._apiCallBack);

  /* FORGOT PASSWORD */
  doForgotpassword(String email) async {
    Map requestParam = toForgotpassword(email);
    RestClient(_apiCallBack).post(requestParam, RequestCode.FORGOT_MAIL);
  }

  Map<String, dynamic> toForgotpassword(
    String email,
  ) =>
      {
        WebFields.EMAIL: email,
      };

  /* Allow notifications */
  doAllowNotification(bool isNotification, String id) async {
    Map requestParam = toAllowNotification(isNotification);
    RestClient(_apiCallBack)
        .post(requestParam, RequestCode.NOTIFICATION_STATUS + id);
  }

  Map<String, dynamic> toAllowNotification(
    bool isNotification,
  ) =>
      {
        WebFields.IS_NOTIFICATION: isNotification,
      };

  /* CHANGE PASSWORD */
  doChangePassword(
      String currentPassword, String newPassword, String id) async {
    Map requestParam = toChangePasswordJson(currentPassword, newPassword);
    RestClient(_apiCallBack)
        .post(requestParam, RequestCode.CHANGE_PASSWORD + id);
  }

  Map<String, dynamic> toChangePasswordJson(
          String currentPass, String newPass) =>
      {
        WebFields.CURRENT_PASS: currentPass,
        WebFields.NEW_PASS: newPass,
      };

  /* Update Profile */
  doUpdateProfile(String fullName, String gender, String bio, String personType,
      String id) async {
    Map requestParam = toUpdateProfile(fullName, gender, bio, personType);
    RestClient(_apiCallBack).put(requestParam, RequestCode.UPDATE_USER + id);
  }

  Map<String, dynamic> toUpdateProfile(
          String fullName, String gender, String bio, String personType) =>
      {
        WebFields.FULL_NAME: fullName,
        WebFields.GENDER: gender,
        WebFields.BIO: gender,
        WebFields.PERSON_TYPE: personType,
        WebFields.STATUS: true,
      };

  Map<String, dynamic> toFavorites(String postId, String userID) =>
      {WebFields.POST_ID: postId, WebFields.USER_ID: userID};

  Map<String, dynamic> toFeedBack(
          String userID, String title, String email, String desc) =>
      {
        WebFields.USER_ID: userID,
        WebFields.TITLE: title,
        WebFields.EMAIL: email,
        WebFields.DESCRIPTION: desc
      };

  /* favorites */
  favorites(String userId, String postId) async {
    Map requestParam = toFavorites(postId, userId);
    RestClient(_apiCallBack).post(requestParam, RequestCode.FAVORITES);
  }

  /* favorites */
  unFavorites(String postId) async {
    RestClient(_apiCallBack).delete('${RequestCode.FAVORITES}/$postId');
  }

  /* getFavorites */
  getFavorites(BuildContext context, String postId) async {
    debugPrint(postId);
    RestClient(_apiCallBack).get(RequestCode.FAVORITES + postId);
  }

  /* for Favorites Listing */
  getFavoritesListing(BuildContext context, String size, String page) async {
    Map requestParam = toJson(
        size, page, await SessionManager.getStringData(WebFields.USER_ID));
    print(requestParam);
    print("REQUEST PARAMA");
    RestClient(_apiCallBack).post(requestParam, RequestCode.FAVORITES_LIST);
  }

  /* send feedback */
  feedBack(String userId, String title, String email, String desc) async {
    Map requestParam = toFeedBack(userId, title, email, desc);
    RestClient(_apiCallBack).post(requestParam, RequestCode.FEEDBACK);
  }

  /* getHtmlPage */
  getHtmlPage(BuildContext context, String id) async {
    debugPrint(id);
    RestClient(_apiCallBack).get(RequestCode.HTML_PAGE + id);
  }

  getSignUpQuestion(BuildContext context) async {
    RestClient(_apiCallBack).get(RequestCode.SIGN_UP_QUIZ);
  }

  Map<String, dynamic> toJson(String size, String page, String userId) => {
        WebFields.SIZE: size,
        WebFields.PAGE: page,
        WebFields.USER_ID: userId,
      };

  /// FOR LOGIN
  doLogin(String email, String password, BuildContext context) async {
    Map requestParam = toLoginJson(
      email,
      password,
    );
    RestClient(_apiCallBack).post(requestParam, RequestCode.LOGIN);
  }

  Map<String, dynamic> toLoginJson(String email, String password) => {
        WebFields.EMAIL: email,
        WebFields.PASSWORD: password,
      };

  doSignup(String fullName, String email, String password,
      BuildContext context) async {
    String fcmToken = '';
    String type = 'App';
    String personType = globals.userType;
    String categoryId = globals.categoryId;
    String socialId = '';
    String gender = globals.gender;
    List<dynamic> questionData = globals.questionData;
    print(type);
    print(personType);
    Map<String, String> requestParam = toSignupJson(fullName, email, password,
        type, personType, categoryId, fcmToken, socialId, gender,questionData);

    print(requestParam);
    RestClient(_apiCallBack).post(requestParam, RequestCode.SIGN_UP);
  }

  Map<String, String> toSignupJson(
          String fullName,
          String email,
          String password,
          String type,
          String personType,
          String categoryId,
          String fcmToken,
          String socialId,
          String gender,
      List<dynamic> questionData) =>
      {
        WebFields.FULL_NAME: fullName,
        WebFields.EMAIL: email,
        WebFields.PASSWORD: password,
        WebFields.TYPE: type,
        WebFields.PERSON_TYPE: personType,
        WebFields.CATEGORY_ID: categoryId,
        WebFields.FCM_TOKEN: fcmToken,
        WebFields.SOCIAL_ID: socialId,
        WebFields.GENDER: gender,
        WebFields.ANSWER: jsonEncode(questionData)
      };

  doSocialLogin(String type, String socialId, String fullName, email, profile,
      BuildContext context) async {
    String fcmToken = '';
    String personType = globals.userType;
    String categoryId = globals.categoryId;
    String gender = globals.gender;
    Map requestParam = toSocialLogin(type, personType, fcmToken, socialId,
        categoryId, fullName, email, profile, gender);
    print(requestParam);
    print("REQUEST PARAMA");
    RestClient(_apiCallBack).post(requestParam, RequestCode.SOCIAL_LOGIN);
  }

  doGoogleLogin(String socialId, String fullName, String email, String profile,
      BuildContext context) async {
    String fcmToken = '';
    String type = 'Google';
    String personType = globals.userType;
    String categoryId = globals.categoryId;
    String gender = globals.gender;
    Map requestParam = toSocialLogin(type, personType, fcmToken, socialId,
        categoryId, fullName, email, profile, gender);
    print(requestParam);
    print("REQUEST PARAMA");
    RestClient(_apiCallBack).post(requestParam, RequestCode.SOCIAL_LOGIN);
  }

  Map<String, dynamic> toSocialLogin(
          String type,
          String personItem,
          String fcmToken,
          String socialId,
          String categoryId,
          String fullName,
          String email,
          String profile,
          String gender) =>
      {
        WebFields.TYPE: type,
        WebFields.PERSON_TYPE: personItem,
        WebFields.FCM_TOKEN: fcmToken,
        WebFields.SOCIAL_ID: socialId,
        WebFields.CATEGORY_ID: categoryId,
        WebFields.FULL_NAME: fullName,
        WebFields.EMAIL: email,
        WebFields.PROFILE: profile,
        WebFields.GENDER: gender
      };

  saveLoginResult(AppUser user) {
    // SessionManager.setIntData(, user.id);
    SessionManager.setStringData(USER_NAME, user.firstName);
    // SessionManager.setStringData(LAST_NAME, user.lastName);
    SessionManager.setStringData(EMAIL, user.email);
  }

  getFeed(BuildContext context) async {
    RestClient(_apiCallBack).get(RequestCode.FEED);
  }

  getChannelList(BuildContext context) async {
    RestClient(_apiCallBack).get(RequestCode.CHANNEL_LIST);
  }

  /// FOR Post LIST
  getPostList(BuildContext context, String type) async {
    debugPrint(type);
    RestClient(_apiCallBack).get('${RequestCode.POST}/?type=$type');
  }

  /* GET USER DETAIL */
  getUserData(BuildContext context, String id) async {
    RestClient(_apiCallBack).get(RequestCode.GET_USER_BY_ID + id);
//    RestClient(_apiCallBack).get('${RequestCode.POST}+ );
  }

  /// FOR Track LIST By ID
  getPlayListById(BuildContext context, String id) async {
    RestClient(_apiCallBack).get('${RequestCode.POST}/$id');
  }

  /// FOR Channel Item List
  getChannelItemList(BuildContext context, String id) async {
    RestClient(_apiCallBack).get('${RequestCode.CHANNEL_Item_LIST}$id');
  }

  /* like/deslike channel post  */
  like(String userId, String channelPostId, String status) async {
    Map requestParam = toPost(userId, channelPostId, status);
    RestClient(_apiCallBack).post(requestParam, RequestCode.CHANNEL_LIKE);
  }

  Map<String, dynamic> toPost(
          String userID, String channelPostId, String status) =>
      {
        WebFields.USER_ID: userID,
        WebFields.CHANNEL_POS_ID: channelPostId,
        WebFields.status: status
      };

  /*comment Listing  */
  commentListing(BuildContext context, String channelPostId) async {
    RestClient(_apiCallBack)
        .get('${RequestCode.COMMENT_LISTING}$channelPostId');
  }

  /* add comment post  */
  commentPost(String userId, String channelPostId, String comment) async {
    Map requestParam = toComment(userId, channelPostId, comment);
    RestClient(_apiCallBack).post(requestParam, RequestCode.ADD_COMMENT);
  }

  Map<String, dynamic> toComment(
          String userID, String channelPostId, String comment) =>
      {
        WebFields.USER_ID: userID,
        WebFields.CHANNEL_POS_ID: channelPostId,
        WebFields.COMMENT: comment
      };

  /* add habit item */
  addHabit(Habit habit, List<Goals> goal) async {
    Map requestParam = habits(habit, goal);
    debugPrint(requestParam.toString());
    RestClient(_apiCallBack).post(requestParam, RequestCode.HABIT);
  }

  /* edit habit item */
  editHabit(Habit habit, List<GoalUpdate> goal, String id) async {
    Map requestParam = habitsUpdate(habit, goal);
    debugPrint(requestParam.toString());
    RestClient(_apiCallBack).put(requestParam, RequestCode.HABIT + "/" + id);
  }

  Map<String, dynamic> habits(Habit habit, List<Goals> goal) => {
        WebFields.USER_ID: habit.userId,
        WebFields.TITLE: habit.title,
        WebFields.DESC: habit.desc,
        WebFields.GOALS: jsonEncode(goal.map((e) => e.toJson()).toList())
      };


  Map<String, dynamic> habitsUpdate(Habit habit, List<GoalUpdate> goal) => {
    WebFields.USER_ID: habit.userId,
    WebFields.TITLE: habit.title,
    WebFields.DESC: habit.desc,
    WebFields.GOALS: jsonEncode(goal.map((e) => e.toJson()).toList())
  };

  /*get Habit List by userId   */
  habitListByUserId(BuildContext context) async {
    var userId = await SessionManager.getStringData(WebFields.USER_ID);

    RestClient(_apiCallBack).get('${RequestCode.HABIT_LIST_BY_USERID}$userId');
  }

  /*get Habit List by habitID   */
  habitListByHabitId(BuildContext context, String habitID) async {
    RestClient(_apiCallBack)
        .get('${RequestCode.HABIT_LIST_BY_HABIT_ID}$habitID');
  }

  /* add habit item */
  updateHabit(String goalID, String habitID, String name, String status) async {
    var userId = await SessionManager.getStringData(WebFields.USER_ID);

    Map requestParam = uHabit(userId, habitID, name, status);
    debugPrint(requestParam.toString());
    RestClient(_apiCallBack).put(requestParam, "goal/" + goalID);
  }

  /*get Habit List by userId   */
  deleteHabit(BuildContext context, String habitID) async {
    RestClient(_apiCallBack).delete('${RequestCode.HABIT}/$habitID');
  }

  Map<String, dynamic> uHabit(
          String userId, String habitId, String name, String status) =>
      {
        WebFields.USER_ID: userId,
        "habit_id": habitId,
        "name": name,
        "status": status
      };
}
