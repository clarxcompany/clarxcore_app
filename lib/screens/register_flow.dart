// lib/screens/register_flow.dart

import 'package:flutter/material.dart';

// import all 11 steps:
import 'register_pages/step1_basic_info.dart';
import 'register_pages/step2_profile_contact.dart';
import 'register_pages/step3_sport_task_preferences.dart';
import 'register_pages/step4_advanced_sport_task_data.dart';
import 'register_pages/step5_device_integrations.dart';
import 'register_pages/step6_location_weather.dart';
import 'register_pages/step7_daily_routine.dart';
import 'register_pages/step8_community_settings.dart';
import 'register_pages/step9_subscription_payment.dart';
import 'register_pages/step10_security_permissions.dart';
import 'register_pages/step11_terms_agreements.dart';

/// Holds everything the user enters across all 11 steps.
class RegisterData {
  // Step 1
  String fullName = '';
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  DateTime? birthDate;
  String? gender;

  // Step 2
  String? profilePhoto;
  String? timezone;
  String? language;
  bool notifyDailyTasks = true;
  bool notifyAIRecommendations = true;
  bool notifyCommunityInvites = true;
  bool notifyWeeklyReport = false;

  // Step 3
  List<String> favoriteSports = [];
  int weeklySessions = 0;
  int avgSessionDuration = 0;
  List<String> preferredTimeSlots = [];
  String? sportEnvironment;
  List<String> equipment = [];
  List<String> motivations = [];
  List<String> taskCategories = [];
  Map<String,int> categoryPriority = {};
  int dailyTaskTarget = 1;
  String repeatFrequency = 'Günlük';
  String difficultyLevel = 'Orta';
  List<String> quickStartPlans = [];

  // Step 4
  int dailyStepGoal = 0;
  int weeklyActivityGoal = 0;
  List<String> shortTermGoals = [];
  List<String> longTermGoals = [];
  String experienceLevel = 'Yeni Başlayan';
  List<String> healthConditions = [];
  String workSchedule = '';
  String groupSoloPreference = 'Solo';
  bool allowSocialShare = false;

  // Step 5
  bool syncHealth = false;
  bool wearablePermission = false;
  List<String> calendarIntegrations = [];
  bool pushNotification = true;
  bool emailNotification = true;

  // Step 6
  String cityOrPostal = '';
  bool autoWeatherNotification = false;

  // Step 7
  TimeOfDay? wakeTime;
  TimeOfDay? sleepTime;
  String workHours = '';
  String breakPreferences = '';
  bool mealWaterReminders = false;

  // Step 8
  bool allowFriendRequests = true;
  bool joinTeamTasks = false;
  bool leaderboardVisibility = false;
  List<String> communityGroups = [];

  // Step 9
  String subscriptionPlan = '';
  String paymentMethod = '';
  String billingAddress = '';

  // Step 10
  bool biometricAuth = false;
  bool gpsPermission = false;
  bool micPermission = false;
  bool apiAccess = false;

  // Step 11
  bool termsAccepted = false;
  bool liabilityWaiverAccepted = false;
  bool marketingOptIn = false;
  bool analyticsOptIn = false;
}

class RegisterFlow extends StatefulWidget {
  const RegisterFlow({Key? key}) : super(key: key);

  @override
  State<RegisterFlow> createState() => _RegisterFlowState();
}

class _RegisterFlowState extends State<RegisterFlow> {
  final _controller = PageController();
  final _data = RegisterData();
  int _currentPage = 0;

  void _next() {
    if (_currentPage < 10) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _back() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar here: each step handles its own header / back button
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => _currentPage = i),
        children: [
          // 1. adım: ilk sayfada geri 'pop' ile önceki ekrana dönsün
          Step1BasicInfo(
            data: _data,
            onNext: _next,
            onBack: () => Navigator.of(context).pop(),
          ),

          // 2. adım ve sonrası:
          Step2ProfileContact(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step3SportTaskPreferences(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step4AdvancedSportTaskData(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step5DeviceIntegrations(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step6LocationWeather(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step7DailyRoutine(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step8CommunitySettings(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step9SubscriptionPayment(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),
          Step10SecurityPermissions(
            data: _data,
            onNext: _next,
            onBack: _back,
          ),

          // 11. adım: son adım olduğu için sadece back
          Step11TermsAgreements(
            data: _data,
            onBack: _back,
          ),
        ],
      ),
    );
  }
}
