# from fastapi import FastAPI, Query
# import subprocess
# import os

# app = FastAPI()

# @app.get("/filter_pcap")
# async def filter_pcap(ip_list: str = Query(...)):
#     ip_list = ip_list.split(",")  # Convert comma-separated string to a list of IPs
#     username = os.getlogin()
#     input_file = f"C:\\Users\\{username}\\captured_packets.pcap"  # Replace with your pcap file
#     filtered_pcap_file = f"C:\\Users\\{username}\\filtered.pcap"
#     filtered_csv_file = f"C:\\Users\\{username}\\filtered.csv"

#     try:
#         # Filtering pcap file
#         ip_filter = " or ".join([f"ip.addr == {ip}" for ip in ip_list])
#         pcap_filter_command = f'tshark -r {input_file} -Y "{ip_filter}" -w {filtered_pcap_file}'
#         subprocess.run(pcap_filter_command, shell=True, check=True)
#         print(pcap_filter_command)
        
        
#         # Creating CSV file
#         fields = ["frame.number", "frame.time" , "ip.src", "ip.dst", "frame.protocols", "_ws.col.Info"]
#         fields_str = " ".join(["-e " + field for field in fields])
#         csv_command = f"tshark -r {filtered_pcap_file} -T fields {fields_str} -E separator=, -E quote=d > {filtered_csv_file}"
#         print(csv_command)
#         subprocess.run(csv_command, shell=True, check=True)

#         return {"message": "Filtered files created successfully."}
#     except subprocess.CalledProcessError as e:
#         return {"error": f"Command execution failed: {e}"}

from fastapi import FastAPI, Query
import subprocess
import os

app = FastAPI()

@app.get("/filter_pcap")
async def filter_pcap(ip_list: str = Query(...)):
    ip_list = ip_list.split(",")  # Convert comma-separated string to a list of IPs
    username = os.getlogin()
    input_file = f"C:\\Users\\{username}\\captured_packets.pcap"  # Replace with your pcap file
    filtered_pcap_file = f"C:\\Users\\{username}\\filtered.pcap"
    filtered_csv_file = f"C:\\Users\\{username}\\filtered.csv"

    try:
        # Filtering pcap file
        ip_filters = []

        for ip in ip_list:
            ip_blocks = ip.split(".")[:2]  # Get the first two IP blocks
            ip_filter = f"ip.addr == {'.'.join(ip_blocks)}.0.0/16"
            ip_filters.append(ip_filter)

        ip_filter = " or ".join(ip_filters)
        pcap_filter_command = f'tshark -r {input_file} -Y "{ip_filter}" -w {filtered_pcap_file}'
        subprocess.run(pcap_filter_command, shell=True, check=True)
        print(pcap_filter_command)

        # Creating CSV file
        fields = ["frame.number", "frame.time", "ip.src", "ip.dst", "frame.protocols", "_ws.col.Info"]
        fields_str = " ".join(["-e " + field for field in fields])
        csv_command = f"tshark -r {filtered_pcap_file} -T fields {fields_str} -E separator=, -E quote=d > {filtered_csv_file}"
        print(csv_command)
        subprocess.run(csv_command, shell=True, check=True)

        return {"message": "Filtered files created successfully."}
    except subprocess.CalledProcessError as e:
        return {"error": f"Command execution failed: {e}"}
