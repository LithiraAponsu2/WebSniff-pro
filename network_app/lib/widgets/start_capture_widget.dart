import 'package:flutter/material.dart';
import '../services/capture_api.dart'; // Replace with your actual import path

class StartCaptureWidget extends StatelessWidget {
  final VoidCallback onCaptureStart;

  StartCaptureWidget({required this.onCaptureStart});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ApiCalls.startCapture().then((_) {
          onCaptureStart(); // Notify HomePage when capture starts
          // Additional logic after starting the capture can be added here
        });
      },
      child: const Text('Start Capture'),
    );
  }
}
