class RequestCode {
  static const String apiEndPoint = 'http://52.14.72.215:3000/';
  static const String LOGIN = 'auth/login';
  static const String SIGN_UP = 'user/create';
  static const String SOCIAL_LOGIN = 'auth/social';
  static const String FEED = 'feed';
  static const String POST = 'post';
  static const String CHANGE_PASSWORD = 'user/change-password/';
  static const String NOTIFICATION_STATUS = 'user/notification-status/';
  static const String FORGOT_MAIL = 'auth/forgot-mail';
  static const String GET_USER_BY_ID = 'user/getUserById/';
  static const String UPDATE_USER = 'user/';
  static const String FAVORITES = 'favorite';
  static const String HTML_PAGE = 'html-page/';
  static const String SIGN_UP_QUIZ = 'quiz';
  static const String FEEDBACK = 'feedback';
  static const String CHANNEL_LIKE = 'channel-post/channel-post-like';
  static const String COMMENT_LISTING =
      'channel-post/channel-comment-list?channelId=';
  static const String ADD_COMMENT = 'channel-post/channel-post-comment';
  static const String FAVORITES_LIST = 'favorite/list-by-user';
  static const String CHANNEL_LIST = 'channel';

  static const String CHANNEL_Item_LIST =
      'channel-post?size=10&page=0&channelId=';

  static const String HABIT = "habit";
  static const String HABIT_LIST_BY_USERID = "habit/habit-list-by-user/";
  static const String HABIT_LIST_BY_HABIT_ID = "goal/goal-list-habit/";
}
