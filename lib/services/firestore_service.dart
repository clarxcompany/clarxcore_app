// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/register_flow.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Kullanıcının tüm RegisterData’sını uid altında kaydeder
  Future<void> createUserProfile(String uid, RegisterData data) {
    final doc = _db.collection('users').doc(uid);
    return doc.set({
      'fullName': data.fullName,
      'username': data.username,
      'email': data.email,
      'phone': data.phone,
      'birthDate': data.birthDate?.toIso8601String(),
      'gender': data.gender,
      'profilePhoto': data.profilePhoto,
      'timezone': data.timezone,
      'language': data.language,
      'notifyDailyTasks': data.notifyDailyTasks,
      'notifyAIRecommendations': data.notifyAIRecommendations,
      'notifyCommunityInvites': data.notifyCommunityInvites,
      'notifyWeeklyReport': data.notifyWeeklyReport,
      'favoriteSports': data.favoriteSports,
      'weeklySessions': data.weeklySessions,
      'avgSessionDuration': data.avgSessionDuration,
      'preferredTimeSlots': data.preferredTimeSlots,
      'sportEnvironment': data.sportEnvironment,
      'equipment': data.equipment,
      'motivations': data.motivations,
      'taskCategories': data.taskCategories,
      'categoryPriority': data.categoryPriority,
      'dailyTaskTarget': data.dailyTaskTarget,
      'repeatFrequency': data.repeatFrequency,
      'difficultyLevel': data.difficultyLevel,
      'quickStartPlans': data.quickStartPlans,
      'dailyStepGoal': data.dailyStepGoal,
      'weeklyActivityGoal': data.weeklyActivityGoal,
      'shortTermGoals': data.shortTermGoals,
      'longTermGoals': data.longTermGoals,
      'experienceLevel': data.experienceLevel,
      'healthConditions': data.healthConditions,
      'workSchedule': data.workSchedule,
      'groupSoloPreference': data.groupSoloPreference,
      'allowSocialShare': data.allowSocialShare,
      'syncHealth': data.syncHealth,
      'wearablePermission': data.wearablePermission,
      'calendarIntegrations': data.calendarIntegrations,
      'pushNotification': data.pushNotification,
      'emailNotification': data.emailNotification,
      'cityOrPostal': data.cityOrPostal,
      'autoWeatherNotification': data.autoWeatherNotification,
      'wakeTime': data.wakeTime != null
          ? '${data.wakeTime!.hour.toString().padLeft(2, '0')}:${data.wakeTime!.minute.toString().padLeft(2, '0')}'
          : null,
      'sleepTime': data.sleepTime != null
          ? '${data.sleepTime!.hour.toString().padLeft(2, '0')}:${data.sleepTime!.minute.toString().padLeft(2, '0')}'
          : null,
      'workHours': data.workHours,
      'breakPreferences': data.breakPreferences,
      'mealWaterReminders': data.mealWaterReminders,
      'allowFriendRequests': data.allowFriendRequests,
      'joinTeamTasks': data.joinTeamTasks,
      'leaderboardVisibility': data.leaderboardVisibility,
      'communityGroups': data.communityGroups,
      'subscriptionPlan': data.subscriptionPlan,
      'paymentMethod': data.paymentMethod,
      'billingAddress': data.billingAddress,
      'biometricAuth': data.biometricAuth,
      'gpsPermission': data.gpsPermission,
      'micPermission': data.micPermission,
      'apiAccess': data.apiAccess,
      'termsAccepted': data.termsAccepted,
      'liabilityWaiverAccepted': data.liabilityWaiverAccepted,
      'marketingOptIn': data.marketingOptIn,
      'analyticsOptIn': data.analyticsOptIn,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
