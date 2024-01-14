import 'package:http/http.dart' as http;

class ApiCalls {
  static Future<void> startCapture() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:7000/start_capture')); // Replace with your API endpoint
      if (response.statusCode == 200) {
        print('Capture started successfully');
      } else {
        print('Failed to start capture: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while starting capture: $e');
    }
  }

  static Future<String> stopCapture() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:7000/stop_capture')); // Replace with your API endpoint
      if (response.statusCode == 200) {
        print('Capture stopped successfully');
        String path = r'C:\Users\apons\filtered.csv';
        print(path);
        return path;
      } else {
        print('Failed to stop capture: ${response.statusCode}');
        return ''; // Return empty string on failure
      }
    } catch (e) {
      print('Exception while stopping capture: $e');
      return ''; // Return empty string on exception
    }
  }
}
