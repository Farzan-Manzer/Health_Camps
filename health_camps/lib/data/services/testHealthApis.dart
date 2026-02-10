import 'package:flutter/material.dart';
import 'package:health_camps/data/services/api_client.dart';

class TestHealthApi {
  TestHealthApi._(); // private constructor

  static Future<void> showHealthDialog(BuildContext context) async {
    try {
      final response = await ApiClient.instance.get('/');

      final message = response.data is Map && response.data['message'] != null
          ? response.data['message']
          : response.data.toString();

      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('API Response'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
