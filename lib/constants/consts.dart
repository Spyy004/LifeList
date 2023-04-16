// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lifelist/screens/createbucketscreen.dart';
import 'package:lifelist/screens/profilescreen.dart';
import 'package:lifelist/screens/settingsscreen.dart';
import 'package:lifelist/screens/singlebucketscreen.dart';
import 'package:lifelist/services/index.dart';
import 'package:lifelist/services/navigationservice.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/index.dart';
import '../navigation/routes.dart';
import '../screens/index.dart';

const HOME = 'Home';
const ROOT = 'Root';
const ZERO_BUCKET_LIST_FOUND = '0 Bucket List found';
const LETS_CREATE_BUCKETLIST = "Let's create some bucket Lists";
const SETTINGS = 'Settings';
const CREATE_BUCKET = 'CreateBucket';
const SINGLE_BUCKET = 'SingleBucket';
const PROFILE = 'ProfilePage';
const NAME_ARGS = 'name';
const LETS_GET_STARTED = "Let's get Started";
const TRAVEL = 'Travel';
const FINANCE = 'Finance';
const ADVENTURE = 'Adventure';
const CAREER = 'Career';
const FITNESS = 'Fitness';
const PERSONALITY_DEVELOPMENT = 'Personality Development';
const RELATIONSHIPS = 'Relationships';
const ADD_TASK = 'Add Task';
const YOUR_BUCKETS = 'Your Buckets';
const ONBOARDING = 'Onboarding';
const SELECT_CATEGORY = 'Select Category';
const ADD_DEADLINE = 'Add Deadline';
const ADD_TASKS = 'Add Tasks';
const TASKS = 'Tasks';
const COMPLETED = 'Completed';
const TITLE = 'Title';
const WORLD_TOUR = 'World Tour';
const DESCRIPTION = 'Description';
const KICKING_OFF_DREAMS = 'Kicking Off Dreams';
const CREATE_A_BUCKET = 'Create a Bucket';
const FIRST_NAME = 'First Name';
const JOE_MAMA = 'Joe Mama';
const LAST_NAME = 'Last Name';
const AGE = 'Age';
const AGE_NO = '69';
const PROFILE_TITLE = 'Profile';
const APP_VERSION = 'App Version';
const PROFILE_IMAGE_ASSET = 'assets/profile.png';
const SOURCE_CODE = 'Source Code';
const CLEAR_DATA = 'Clear Data';
const CLEAR_DATA_CONFIRM = 'Clear Data?';
const CANCEL = 'Cancel';
const CONFIRM = 'Confirm';
const STATUS = 'Status';
const FEATURE_COMING_SOON = 'Feature Coming Soon';
const ZERO_TASKS = 'You have got 0 tasks';
const LETS_ADD_TASKS = "Let's add some tasks";
const ATLEAST_ONE_TASK_PROMPT = "A bucket should have atleast one task";
const CLEAR_DATA_SUBTITLE = 'Are you sure you want to clear all data?';

int currIndex = 0;
String appVersion = '0.0.0';
var routes = <String, WidgetBuilder>{
  Routes.homePage: (BuildContext context) => const HomeScreen(),
  Routes.onBoardingPage: (context) => OnboardingScreen(),
  Routes.createBucket: (context) => CreateBucketScreen(),
  Routes.singleBucket: (contex) => BucketDetailsScreen(),
  Routes.profilePage: (context) => ProfilePage(),
  Routes.settingsPage: (context) => SettingsScreen()
};

DBService dbService = DBService();
UserService userService = UserService();
BucketService bucketService = BucketService();
NavigationService navigationService = NavigationService();
TaskService taskService = TaskService();

bool isUserCreated = false;

Map<String, BucketCategory> maps = {
  'Travel': BucketCategory.travel,
  'Finance': BucketCategory.finance,
  'Adventure': BucketCategory.adventure,
  'Career': BucketCategory.career,
  'Fitness': BucketCategory.fitness,
  'Personality Development': BucketCategory.personalitydevelopment,
  'Relationships': BucketCategory.relationships
};

Map<BucketCategory, IconData> categoryMap = {
  BucketCategory.travel: Icons.airplanemode_active,
  BucketCategory.finance: Icons.attach_money,
  BucketCategory.adventure: Icons.hiking,
  BucketCategory.career: Icons.work,
  BucketCategory.fitness: Icons.fitness_center,
  BucketCategory.personalitydevelopment: Icons.sentiment_satisfied,
  BucketCategory.relationships: Icons.people
};
