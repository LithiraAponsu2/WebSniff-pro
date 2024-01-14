import 'package:http/http.dart' as http;

class FilterApi {
  static Future<String> filterPcap(List<String> ips) async {
    try {
      String ipList = ips.join(',');
      Uri url = Uri.parse('http://127.0.0.1:6000/filter_pcap?ip_list=$ipList');
      print('http://127.0.0.1:6000/filter_pcap?ip_list=$ipList');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Assuming the response contains the CSV file path
        String csvFilePath = response.body;
        return csvFilePath;
      } else {
        print('Failed to filter pcap: ${response.statusCode}');
        return ''; // Return empty string on failure
      }
    } catch (e) {
      print('Error filtering pcap: $e');
      return ''; // Return empty string on exception or failure
    }
  }
}
