import 'package:flutter/material.dart';
import 'package:montage/views/audio/audio_list.dart';
import 'package:montage/views/audio/audio_player.dart';
import 'package:montage/views/auth/forgot_password.dart';
import 'package:montage/views/auth/guidline_extra_pages.dart';
import 'package:montage/views/auth/guidline_page02_view.dart';
import 'package:montage/views/auth/guidline_page03_view.dart';
import 'package:montage/views/auth/guidline_page04_view.dart';
import 'package:montage/views/auth/guidline_page05_view.dart';

import 'package:montage/views/auth/guidline_view.dart';
import 'package:montage/views/auth/login_view.dart';
import 'package:montage/views/auth/signup_view.dart';
import 'package:montage/views/auth/welcome_screen_view.dart';
import 'package:montage/views/chat/chat_view.dart';
import 'package:montage/views/habits/add_habit.dart';
import 'package:montage/views/habits/habits.dart';
import 'package:montage/views/home/tab_view.dart';
import 'package:montage/views/myprofile/edit_goal.dart';
import 'package:montage/views/myprofile/favourite.dart';
import 'package:montage/views/myprofile/feedback.dart';
import 'package:montage/views/myprofile/media_view.dart';
import 'package:montage/views/myprofile/profile_view.dart';
import 'package:montage/views/myprofile/settings.dart';
import 'package:montage/views/no_internet/no_internet_view.dart';
import 'package:montage/views/video/video_player.dart';

const String RouteGuideLineView = 'routeGuideLineView';
const String RouteWelcomeView = 'routeWelcomeView';
const String RouteNoInternetConnectionView = 'routeNoInternetConnectionView';
const String RouteGuildlinePage02 = 'routeGuidlinePage02';
const String RouteGuildlinePage03 = 'routeGuidlinePage03';
const String RouteGuildlineExtraPage = 'routeGuidlineExtraPage';
const String RouteSignupView = 'routeSignupView';
const String RouteGuildlinePage04 = 'routeGuidlinePage04';
const String RouteGuildlinePage05 = 'routeGuidlinePage05';
const String RouteLoginView = 'routeLoginView';
const String RouteForgotPasswordView = 'routeForgorPasswordView';
const String RouteTabVIew = 'routeTabView';
const String RouteProfileView = 'routeProfileView';
const String RouteSettingView = 'routeSettingView';
const String RouteFavoriteView = 'routeFavoriteView';
const String RouteMediaView = 'routeMediaView';
const String RouteHabitsView = 'routeHabitsView';
const String RouteEditGoalView = 'routeEditGoal';
const String RouteAudioListView = 'routeAudioList';
const String RouteEditHabitView = 'routeEditHabitView';
const String RouteChatView = 'routeChatView';
const String RouteAudioPlayer = 'routeAudioPlayer';
const String RouteVideoPlayer = 'routeVideoPlayer';
const String FeedBack = 'feedback';

// ignore: missing_return
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteGuideLineView:
      return MaterialPageRoute(builder: (context) => GuidlineView());
    case RouteWelcomeView:
      return MaterialPageRoute(builder: (context) => WelcomeScreenView());
    case RouteNoInternetConnectionView:
      return MaterialPageRoute(
          builder: (context) => NoInternetConnectionView());
    case RouteGuildlinePage02:
      return MaterialPageRoute(builder: (context) => GuidlinePage02View());
    case RouteGuildlinePage03:
      return MaterialPageRoute(builder: (context) => GuidlineView03());
    case RouteGuildlineExtraPage:
      return MaterialPageRoute(builder: (context) => GuidLineExtraPages());
    case RouteSignupView:
      return MaterialPageRoute(builder: (context) => SignupView());
    case RouteGuildlinePage04:
      return MaterialPageRoute(builder: (context) => GuidlineView04());
    case RouteGuildlinePage05:
      return MaterialPageRoute(builder: (context) => GuidlineView05());
    case RouteLoginView:
      return MaterialPageRoute(builder: (context) => LoginView());
    case RouteForgotPasswordView:
      return MaterialPageRoute(builder: (context) => ForgoipasswordView());
    case RouteTabVIew:
      return MaterialPageRoute(builder: (context) => TabView());
    case RouteProfileView:
      return MaterialPageRoute(builder: (context) => ProfileView());
    case RouteSettingView:
      return MaterialPageRoute(builder: (context) => SettingView());
    case RouteFavoriteView:
      return MaterialPageRoute(builder: (context) => FavouriteView());
    case RouteMediaView :
      return MaterialPageRoute(builder: (context) => MediaView());
    case RouteHabitsView:
      return MaterialPageRoute(builder: (context) => HabitsView());
    case RouteEditGoalView:
      return MaterialPageRoute(builder: (context) => EditGoalView());
    case RouteAudioListView:
      return MaterialPageRoute(builder: (context) => AudioList(""));
    case RouteEditHabitView:
      return MaterialPageRoute(builder: (context) => AddHabitView());
    case RouteChatView:
      return MaterialPageRoute(builder: (context) => ChatView());
    case RouteAudioPlayer:
      return MaterialPageRoute(builder: (context) => AudioPlayerList(null));

    case RouteVideoPlayer:
      return MaterialPageRoute(builder: (context) => VideoPlayerList(null));

    case FeedBack:
      return MaterialPageRoute(builder: (context) => FeedBackView());
  }
}
