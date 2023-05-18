// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lifelist/services/index.dart';
import 'package:lifelist/services/navigationservice.dart';
import '../models/index.dart';
import '../navigation/routes.dart';
import '../screens/index.dart';

const HOME = 'Home';
const ROOT = 'Root';
const URL = 'https://github.com/Spyy004/LifeList';
const ZERO_BUCKET_LIST_FOUND = '0 Bucket List found';
const LETS_CREATE_BUCKETLIST = "Let's create some bucket Lists";
const SETTINGS = 'Settings';
const CREATE_BUCKET = 'CreateBucket';
const SINGLE_BUCKET = 'SingleBucket';
const PROFILE = 'ProfilePage';
const EXPLORE = 'Explore';
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
const DELETE_TASK_CONFIRM = "Delete Task?";
const DELETE_BUCKET_CONFIRM = "Delete Bucket?";
const CANCEL = 'Cancel';
const CONFIRM = 'Confirm';
const STATUS = 'Status';
const FEATURE_COMING_SOON = 'Feature Coming Soon';
const ZERO_TASKS = 'You have got 0 tasks';
const LETS_ADD_TASKS = "Let's add some tasks";
const ATLEAST_ONE_TASK_PROMPT = "A bucket should have atleast one task";
const CLEAR_DATA_SUBTITLE = 'Are you sure you want to clear all data?';
const DELETE_TASK_SUBTITLE = 'Are you sure you want to delete this task?';
const DELETE_BUCKET_SUBTITLE = 'Are you sure you want to delete this bucket?';
const DONE = 'Done';
const CREATE = 'Create';
const FEEDBACK_EMAIL = 'i.yush.004@gmail.com';
const FEEDBACK = 'Feedback';
const NOTIFICATION_CHANNEL_ID = 'streak1';
const NOTIFICATION_CHANNEL_NAME = 'streak';
const NOTIFICATION_CHANNEL_DESCRIPTION = 'Notification for streak reminder';
const APP_LOGO = 'app_logo';
int currIndex = 0;
String appVersion = '0.0.0';
var routes = <String, WidgetBuilder>{
  Routes.homePage: (BuildContext context) => const HomeScreen(),
  Routes.onBoardingPage: (context) => OnboardingScreen(),
  Routes.createBucket: (context) => CreateBucketScreen(),
  Routes.singleBucket: (contex) => BucketDetailsScreen(),
  Routes.profilePage: (context) => const ProfilePage(),
  Routes.settingsPage: (context) => SettingsScreen(),
  Routes.feedbackPage: (context) => FeedbackForm(),
  Routes.explorePage: (context) => const ExploreScreen(),
};

DBService dbService = DBService();
UserService userService = UserService();
BucketService bucketService = BucketService();
NavigationService navigationService = NavigationService();
TaskService taskService = TaskService();
FirebaseService firebaseService = FirebaseService();

const categories = [
  'Travel',
  'Finance',
  'Adventure',
  'Career',
  'Fitness',
  'Personality Development',
  'Relationships',
];

const scopes = ['Onetime', 'Daily', 'All'];

const createScopes = ['Onetime', 'Daily'];

Map<String, BucketScope> stringToBucketScope = {
  'Onetime': BucketScope.onetime,
  'Daily': BucketScope.daily,
  'All': BucketScope.all
};

Map<BucketScope, String> bucketScopeToString = {
  BucketScope.onetime: 'Onetime',
  BucketScope.daily: 'Daily'
};

bool isUserCreated = false;

Map<String, BucketCategory> stringToBucketCategory = {
  'Travel': BucketCategory.travel,
  'Finance': BucketCategory.finance,
  'Adventure': BucketCategory.adventure,
  'Career': BucketCategory.career,
  'Fitness': BucketCategory.fitness,
  'Personality Development': BucketCategory.personalitydevelopment,
  'Relationships': BucketCategory.relationships,
  'travel': BucketCategory.travel
};

Map<BucketCategory, String> bucketCategoryToString = {
  BucketCategory.travel: 'Travel',
  BucketCategory.finance: 'Finance',
  BucketCategory.adventure: 'Adventure',
  BucketCategory.career: 'Career',
  BucketCategory.fitness: 'Fitness',
  BucketCategory.personalitydevelopment: 'Personality Development',
  BucketCategory.relationships: 'Relationships'
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

Map<BucketScope, IconData> scopeMap = {
  BucketScope.onetime: Icons.done,
  BucketScope.daily: Icons.hourglass_bottom,
  BucketScope.all: Icons.handshake
};
