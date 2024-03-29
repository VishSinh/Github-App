import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackbarShowWarning(String message, {String title = 'Error'}) {
  if (message.contains('Exception:')) {
    message = message.replaceAll('Exception:', '');
  }

  Get.snackbar(title, message, backgroundColor: Colors.red.shade400, colorText: Colors.black);
}
