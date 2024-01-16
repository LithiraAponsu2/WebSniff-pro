import 'package:flutter/material.dart';
import '../services/capture_api.dart'; // Replace with your actual import path
import '../services/filter_pcap_api.dart'; // Replace with your actual import path
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class StopCaptureWidget extends StatelessWidget {
  final List<String> ips;
  final VoidCallback onCaptureStop;

  StopCaptureWidget({required this.ips, required this.onCaptureStop});

  Future<void> _saveFile(BuildContext context, String pcapFilePath) async {
    try {
      Directory? downloadsDirectory = await getDownloadsDirectory();
      if (downloadsDirectory != null) {
        File sourceFile = File(r'C:\Users\apons\filtered.pcap');
        String timestamp =
            DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
        String fileName = 'filtered_$timestamp.pcap';
        String newPath = '${downloadsDirectory.path}/$fileName';
        await sourceFile.copy(newPath);
        _showDownloadDialog(context, 'File saved to Downloads');
      } else {
        _showDownloadDialog(context, 'Could not save file.');
      }
    } catch (e) {
      _showDownloadDialog(context, 'Error: $e');
    }
  }

  void _showDownloadDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Status'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          String pcapFilePath = await ApiCalls.stopCapture();
          if (pcapFilePath.isNotEmpty) {
            await FilterApi.filterPcap(ips);
            String pcapData = await _readPCAPData(pcapFilePath);
            if (pcapData.isNotEmpty) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('PCAP Data'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Route IPs:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ips.map((ip) {
                            return Chip(
                              label: Text(ip),
                              backgroundColor: Colors
                                  .blueGrey[800], // Change background color
                              labelStyle: TextStyle(
                                  color: Colors.white), // Change text color
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'PCAP Content:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: _buildColumns(),
                            rows: _buildRows(pcapData),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => _saveFile(context, pcapFilePath),
                      child: Text('Save PCAP'),
                    ),
                  ],
                ),
              );
            } else {
              // Handle the case where PCAP data is empty or unavailable
            }
          } else {
            // Handle the case where the PCAP file path is empty or unavailable
          }
        } catch (e) {
          // Handle API call failure or errors
          print('Error: $e');
        }
        onCaptureStop(); // Notify HomePage when capture stops
      },
      child: const Text('Stop Capture'),
    );
  }

  Future<String> _readPCAPData(String pcapFilePath) async {
    try {
      File file = File(pcapFilePath);
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        print("File does not exist.");
        return '';
      }
    } catch (e) {
      print("Error reading file: $e");
      return '';
    }
  }

  List<DataColumn> _buildColumns() {
    List<String> dummyColumnNames = [
      'Frame No.',
      'Time',
      'Source IP',
      'Destination IP',
      'Protocols',
      'Info'
    ];

    return dummyColumnNames.map((columnName) {
      return DataColumn(label: Text(columnName));
    }).toList();
  }

  List<DataRow> _buildRows(String pcapData) {
    List<String> rows = pcapData.split('\n');
    rows.removeWhere((element) => element.isEmpty);
    rows.removeAt(0);

    return rows.map((row) {
      List<String> rowData = row.split('","');
      return DataRow(
        cells: rowData.map((cell) {
          String cellValue = cell.replaceAll('"', '');
          return DataCell(Text(cellValue));
        }).toList(),
      );
    }).toList();
  }
}
