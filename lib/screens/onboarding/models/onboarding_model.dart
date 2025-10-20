import '../../../gen/assets.gen.dart';

class OnboardingModel {
  final String imagePath;
  final String title;
  final String brief;
  const OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.brief,
  });

  static List<OnboardingModel> onBoardingTabsData = [
    OnboardingModel(
      imagePath: Assets.images.onboarding.a2.path,
      title: 'Find Events That Inspire You',
      brief:
          'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
    ),
    OnboardingModel(
      imagePath: Assets.images.onboarding.a3.path,
      title: 'Effortless Event Planning',
      brief:
          'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
    ),
    OnboardingModel(
      imagePath: Assets.images.onboarding.a4.path,
      title: 'Connect with Friends & Share Moments',
      brief:
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    ),
  ];
}
