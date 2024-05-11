# Packet Capture and Analysis Software for Windows

## Overview
This project focuses on developing a Windows software application using Flutter for capturing and analyzing network packets generated during a single web search. The software provides a user-friendly interface to initiate packet capture, visualize captured data, and perform basic analysis on network traffic.

## Demo
https://github.com/LithiraAponsu2/Capture-Website/assets/95391677/9fa00ae8-60c1-4ee8-babd-dfac5deb2cd2

## Features
- **Packet Capture**: Capture network packets generated during a single web search session.
- **Live Packet Visualization**: Display real-time visualization of captured packets, including packet size, source/destination addresses, and protocols.
- **Packet Filtering**: Implement filtering mechanisms to focus on packets relevant to the web search session.
- **Basic Analysis**: Perform basic analysis on captured packets, such as identifying HTTP requests/responses and analyzing packet timing.

## Theories and Technologies Used
- **Packet Sniffing**: Utilize packet sniffing techniques to intercept and capture network packets passing through the network interface.
- **WinPcap/Libpcap**: Interface with WinPcap (Windows) or Libpcap (Unix-like systems) library for packet capture functionality.
- **Flutter**: Develop the graphical user interface (GUI) using Flutter, a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart Programming Language**: Write the application logic using Dart, the programming language used in Flutter development.
- **Network Protocol Analysis**: Implement basic network protocol analysis to interpret captured packet data, focusing on HTTP for web search-related traffic.

## Usage
1. **Start Capture**: Initiate packet capture session by clicking the "Start Capture" button.
2. **Perform Web Search**: Conduct a web search within the software or use an external web browser.
3. **Capture Analysis**: View real-time visualization of captured packets and perform basic analysis on captured data.
4. **Stop Capture**: End packet capture session and review captured packet data.

## Results
- Successfully developed a Windows software application using Flutter for packet capture and analysis.
- Provided an intuitive user interface for initiating packet capture sessions and visualizing captured packet data.
- Demonstrated basic analysis capabilities for interpreting network traffic related to a single web search session.

## Future Improvements
- Enhance packet filtering capabilities to focus on specific types of web search-related traffic (e.g., image requests, JavaScript files).
- Implement more advanced analysis features, such as packet reconstruction and protocol-specific analysis (e.g., HTTPS decryption).
- Extend platform support to other operating systems (e.g., macOS, Linux) by leveraging cross-platform capabilities of Flutter.

## Conclusion
The development of this packet capture and analysis software using Flutter demonstrates the potential of cross-platform frameworks in creating desktop applications with advanced networking capabilities. By providing a user-friendly interface for capturing and analyzing network packets, the software contributes to network troubleshooting and security analysis tasks in Windows environments.
