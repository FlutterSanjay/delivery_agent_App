import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text("Help & Support"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Obx(() {
        final filteredFaqs = controller.faqs.where((faq) {
          final query = controller.searchTerm.value.toLowerCase();
          return query.isEmpty || faq["q"]!.toLowerCase().contains(query);
        }).toList();

        return ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            // Search bar
            TextField(
              onChanged: (value) => controller.searchTerm.value = value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                hintText: "Search",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // FAQs
            Text(
              "FAQs",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ...filteredFaqs.map((faq) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ExpansionTile(
                  title: Text(
                    faq["q"]!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: Text(
                        faq["a"]!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: 20.h),

            // Contact options
            Text(
              "Need More Help?",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Row(
              spacing: 20.r,
              children: [
                Icon(Icons.call, color: Colors.deepOrange),
                Text("+91-8013812268"),
              ],
            ),
          ],
        );
      }),
    );
  }
}
