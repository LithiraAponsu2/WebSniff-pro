import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> fetchIPsFromAPI(
    Function(List<String>) onIPAddressesFetched, String selectedDomain) async {
  try {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/get_ip_addresses?domain=$selectedDomain'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Handle the response data here
      final List<dynamic> data = json.decode(response.body)['ip_addresses'];
      final List<String> ipAddresses =
          data.cast<String>(); // Assuming data is a List<String>

      onIPAddressesFetched(ipAddresses); // Pass fetched IPs to the callback
      print('Response: $ipAddresses');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
