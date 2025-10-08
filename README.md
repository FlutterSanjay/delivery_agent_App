# delivery_agent
 /// Simulate payment completion

 
  Future<void> completePayment(BuildContext context) async {
    isLoading.value = true;

    // fake transaction id (random banaya practice ke liye)
    String txnId = DateTime.now().millisecondsSinceEpoch.toString();
    print("Transaction Id:$txnId");

    // // Payment data
    // Map<String, dynamic> paymentData = {
    //   "transactionId": txnId,
    //   "agentId": storage.getAgentId(),
    //   "storeId": storeId,
    //   "amount": total,
    //   "storeName": storeName,
    //   "productQuantity": productQuantity,
    //   "status": "success",
    // };

    try {
      //   // REST API call (replace with your backend URL)
      //   var response = await http.post(
      //     Uri.parse("https://your-backend.com/api/payments"),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(paymentData),
      //   );

      isLoading.value = false;

      // if (response.statusCode == 200) {
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
            PaymentSuccessDialog(transactionId: txnId, amount: total),
      ).then((_) {
        // Redirect to success page after closing dialog
        Get.off(() => StoreAssignView());
      });
      // } else {
      // Get.snackbar("Error", "Failed to store payment in backend");
      // }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }