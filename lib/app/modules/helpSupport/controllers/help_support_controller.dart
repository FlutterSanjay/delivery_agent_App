import 'package:get/get.dart';

class HelpSupportController extends GetxController {
  var searchTerm = "".obs;

  // FAQs list
  final faqs = [
    {
      "q": "How to reset my password?",
      "a":
          "Go to Profile > Security > Change Password. Follow on-screen instructions to set a new password.",
    },
    {
      "q": "Where can I find my transaction history?",
      "a":
          "Transaction history is available in the Payments section. You can view past transactions and download statements.",
    },
    {
      "q": "How do I update my profile information?",
      "a":
          "Navigate to the Profile tab. Here you can edit your name, contact details, and other personal info.",
    },
    {
      "q": "Is my data secure?",
      "a":
          "Yes, we use industry-standard encryption and security protocols to protect your data.",
    },
    {
      "q": "How do I change my email or phone number linked to the account?",
      "a":
          "Go to Profile > Personal Info. Select the field you want to update, enter the new details, and save changes.",
    },
    {
      "q": "What should I do if I forgot my password and can’t log in?",
      "a":
          "On the login screen, tap ‘Forgot Password’. Enter your registered email or phone to receive reset instructions.",
    },
    {
      "q": "Can I enable two-factor authentication (2FA) for better security?",
      "a":
          "Yes. Go to Profile > Security and enable 2FA. You can choose SMS or authenticator app verification.",
    },
    {
      "q": "How do I log out from all devices for safety?",
      "a":
          "Go to Profile > Security > Active Sessions. Select ‘Log out from all devices’ to secure your account.",
    },
    {
      "q": "How can I download my monthly statements?",
      "a":
          "Go to Payments > Statements. Choose the month and tap ‘Download’ to save it as a PDF.",
    },
    {
      "q": "Why is my payment not showing in transaction history?",
      "a":
          "Sometimes payments take a few minutes to update. If it’s missing after 24 hours, please contact support.",
    },
    {
      "q": "Can I get a refund if a transaction fails?",
      "a":
          "Yes. Failed transactions are usually refunded automatically within 5–7 business days.",
    },
    {
      "q": "How long does it take for a payment to reflect?",
      "a":
          "Most payments reflect instantly. In rare cases, it may take up to 24 hours depending on your bank.",
    },
    {
      "q": "How do I update my profile picture?",
      "a":
          "Go to Profile > Edit Profile. Tap your photo and select a new picture from your gallery or camera.",
    },
    {
      "q": "Can I delete or deactivate my account?",
      "a":
          "Yes. Go to Profile > Account Settings. Choose ‘Deactivate Account’ or contact support for permanent deletion.",
    },
    {
      "q": "How do I manage my notification preferences?",
      "a":
          "Go to Settings > Notifications. Toggle the options to enable or disable alerts for your account.",
    },
    {
      "q": "Can I request deletion of my stored data?",
      "a":
          "Yes. Go to Profile > Privacy and select ‘Request Data Deletion’. Our team will process it as per policy.",
    },
    {
      "q": "Is my information shared with third parties?",
      "a":
          "We do not sell your data. Some trusted third-party services may be used for payments or analytics under strict agreements.",
    },
    {
      "q": "How do I report a security concern or suspicious activity?",
      "a":
          "Go to Help & Support > Report Issue. Select ‘Security Concern’ and describe the issue in detail.",
    },
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
