import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../AppColor/appColor.dart';

import '../../../data/model/delivery_agent_profile_model.dart';

class DeliveryAgentProfileController extends GetxController {
  // Comment out the API service instantiation as we're using static data
  // final DeliveryAgentApiService _apiService = DeliveryAgentApiService();

  // Observable for the agent's profile data
  final Rx<DeliveryAgentProfile?> agentProfile = Rx<DeliveryAgentProfile?>(null);

  // UI state variables
  final RxBool isLoading = true.obs;
  final RxBool isEditing = false.obs; // Controls edit mode
  final RxString errorMessage = ''.obs;

  // Text editing controllers for editable fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController vehiclePlateNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Store original profile data for 'Cancel' functionality
  DeliveryAgentProfile? _originalProfile;

  @override
  void onInit() {
    super.onInit();
    fetchAgentProfile('agent_123'); // Still call to "fetch", but it will use static data
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    vehicleTypeController.dispose();
    vehiclePlateNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  /// Fetches the delivery agent's profile using static sample data.
  Future<void> fetchAgentProfile(String agentId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // --- Static Sample Data ---
      final DeliveryAgentProfile sampleProfile = DeliveryAgentProfile(
        id: agentId,
        name: 'Jane Smith',
        phoneNumber: '+91 99887 76655',
        email: 'jane.smith@example.com',
        vehicleType: 'Scooter',
        vehiclePlateNumber: 'WB-02-CD-7890',
        address: '456, Green Park, Salt Lake City, Kolkata, India - 700091',
        status: 'active',
        rating: 4.5,
        totalDeliveries: 987,
        profilePictureUrl: 'assets/image/store.jpg', // Another example image
      );

      agentProfile.value = sampleProfile;
      _originalProfile = sampleProfile; // Store original for cancel functionality
      _populateControllers(sampleProfile); // Populate controllers after "fetching"
    } catch (e) {
      // In a real app, this would catch actual network/parsing errors
      errorMessage.value = 'Failed to load profile from static data: $e';
      Get.snackbar(
        'Error',
        'Failed to load profile: ${errorMessage.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.redColor,
        colorText: AppColor.onPrimary,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Populates text controllers with current profile data.
  void _populateControllers(DeliveryAgentProfile profile) {
    nameController.text = profile.name!;
    phoneController.text = profile.phoneNumber!;
    emailController.text = profile.email!;
    vehicleTypeController.text = profile.vehicleType!;
    vehiclePlateNumberController.text = profile.vehiclePlateNumber!;
    addressController.text = profile.address!;
  }

  /// Toggles between view and edit mode.
  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    if (isEditing.value) {
      // When entering edit mode, save a copy of current profile as original
      _originalProfile = agentProfile.value?.copyWith();
    } else {
      // If exiting edit mode without saving, revert changes
      cancelEdit();
    }
  }

  /// Cancels editing and reverts changes to the last loaded/saved state.
  void cancelEdit() {
    if (_originalProfile != null) {
      agentProfile.value = _originalProfile; // Revert the observable
      _populateControllers(_originalProfile!); // Re-populate controllers
    }
    isEditing.value = false; // Exit edit mode
    errorMessage.value = ''; // Clear any error messages
  }

  /// Saves the updated profile data (to static data in this case).
  Future<void> saveProfile() async {
    if (agentProfile.value == null) {
      errorMessage.value = 'No profile data to save.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Simulate network delay for saving
      await Future.delayed(const Duration(seconds: 1));

      // Create a new profile object with updated data from controllers
      final updatedProfile = agentProfile.value!.copyWith(
        name: nameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        vehicleType: vehicleTypeController.text,
        vehiclePlateNumber: vehiclePlateNumberController.text,
        address: addressController.text,
        // For static data, rating/totalDeliveries are usually not updated by user
        // profilePictureUrl: // You'd handle image upload separately and update this
      );

      // --- Update the static data directly ---
      agentProfile.value = updatedProfile;
      _originalProfile = updatedProfile; // Update original for future cancels

      isEditing.value = false; // Exit edit mode on success

      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.greenColor,
        colorText: AppColor.onPrimary,
      );
    } catch (e) {
      errorMessage.value = 'Failed to update profile: $e';
      Get.snackbar(
        'Error',
        'Failed to update profile: ${errorMessage.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.redColor,
        colorText: AppColor.onPrimary,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
