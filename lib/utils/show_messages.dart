import 'package:flutter/material.dart';

import '../main.dart';
import 'app_theme.dart';

void showMsg(String? msg, [bool isError = true]) {
  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(msg ?? ""),
    backgroundColor: isError ? AppTheme.error : AppTheme.success,
  ));
}