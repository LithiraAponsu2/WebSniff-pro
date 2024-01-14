from fastapi import FastAPI
import subprocess
import os

app = FastAPI()

capture_process = None

@app.get("/start_capture")
async def start_capture():
    global capture_process
    if capture_process is not None:
        return {"message": "Capture already running."}

    username = os.getlogin()  # Retrieve the current username
    # Example command to start tshark capture - replace with your desired options
    output_file = f"C:\\Users\\{username}\\captured_packets.pcap"  # Output file for captured packets
    cmd = [
        "tshark",
        "-i", "Wi-Fi",  # Replace 'eth0' with your interface name
        "-w", output_file,  # Save the output file to C:
        # "-a", "duration:10"  # Capture duration (e.g., 10 seconds)
        # Add more parameters as needed
    ]

    try:
        capture_process = subprocess.Popen(cmd)
        return {"message": "Capture started successfully."}
    except Exception as e:
        return {"error": str(e)}

@app.get("/stop_capture")
async def stop_capture():
    global capture_process
    if capture_process is None:
        return {"message": "No capture process running."}

    try:
        capture_process.terminate()  # Terminate the capture process
        capture_process = None
        return {"message": "Capture stopped."}
    except Exception as e:
        return {"error": str(e)}
