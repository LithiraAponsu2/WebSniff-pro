import 'package:flutter/material.dart';
import '../widgets/start_capture_widget.dart';
import '../widgets/stop_capture_widget.dart';
import '../widgets/search_bar.dart'; // Replace with your actual import path

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> ipAddresses = [' ', ' ']; // List to store fetched IP addresses
  String? selectedWebsite;
  bool isCapturing = false; // Variable to track capture state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(color: Colors.grey[900]),
        cardTheme: CardTheme(color: Colors.grey[800]),
        hintColor: Colors.blue,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Search(
                onIPAddressesFetched: (List<String> ips) {
                  setState(() {
                    ipAddresses = ips;
                  });
                },
                onSelectWebsite: (String website) {
                  setState(() {
                    selectedWebsite = website;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StartCaptureWidget(
                    onCaptureStart: () {
                      setState(() {
                        isCapturing = true;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  StopCaptureWidget(
                    ips: ipAddresses,
                    onCaptureStop: () {
                      setState(() {
                        isCapturing = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (isCapturing) CircularProgressIndicator(),
              SizedBox(height: 20),
              Container(
                width: 200,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Route IPs:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: ipAddresses.map((ip) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                                child: Text(ip),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const HomePage());
}
