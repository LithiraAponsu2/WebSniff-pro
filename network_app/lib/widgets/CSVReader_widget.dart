// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:intl/intl.dart';

// class CSVShowWidget extends StatelessWidget {
//   final String csvFilePath;

//   const CSVShowWidget({Key? key, required this.csvFilePath}) : super(key: key);

//   Future<void> _saveFile(BuildContext context) async {
//     try {
//       Directory? downloadsDirectory = await getDownloadsDirectory();
//       if (downloadsDirectory != null) {
//         File sourceFile = File(r'C:\Users\apons\filtered.pcap');
//         String timestamp =
//             DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
//         String fileName =
//             'sample_pcap_$timestamp.pcap'; // Updated file name with timestamp
//         String newPath = '${downloadsDirectory.path}/$fileName';
//         await sourceFile.copy(newPath);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('File saved to Downloads'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Could not save file.'),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CSV Data'),
//         actions: [
//           IconButton(
//             onPressed: () => _saveFile(context),
//             icon: Icon(Icons.save),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: FutureBuilder<String>(
//           future: _readCSVData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No data available'));
//             } else {
//               return Center(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: _buildColumns(snapshot.data!),
//                     rows: _buildRows(snapshot.data!),
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<String> _readCSVData() async {
//     try {
//       File file = File(csvFilePath);
//       if (await file.exists()) {
//         return await file.readAsString();
//       } else {
//         print("File does not exist.");
//         return '';
//       }
//     } catch (e) {
//       print("Error reading file: $e");
//       return '';
//     }
//   }

//   List<DataColumn> _buildColumns(String csvData) {
//     // Provide dummy names to columns
//     List<String> dummyColumnNames = [
//       'Column A',
//       'Column B',
//       'Column C',
//       'Column D',
//       'Column E'
//     ];

//     return dummyColumnNames.map((columnName) {
//       return DataColumn(label: Text(columnName));
//     }).toList();
//   }

//   List<DataRow> _buildRows(String csvData) {
//     // Extract rows from the CSV data and create DataRow list
//     List<String> rows = csvData.split('\n');
//     rows.removeWhere((element) => element.isEmpty); // Remove empty rows
//     rows.removeAt(0); // Remove the header row

//     return rows.map((row) {
//       List<String> rowData = row.split('","');
//       return DataRow(
//         cells: rowData.map((cell) {
//           String cellValue = cell.replaceAll('"', '');
//           return DataCell(Text(cellValue));
//         }).toList(),
//       );
//     }).toList();
//   }
// }
