# this use nslookup on windows -> rejected due to only show only 1 ip

from fastapi import FastAPI, Query
import subprocess

app = FastAPI()

def get_ip_addresses(domain):
    # Run the nslookup command with the provided domain
    cmd = f'nslookup -type=A {domain} | findstr "Address"'
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        shell=True
    )

    ip_addresses = []

    # Split the output by lines
    lines = result.stdout.split('\n')

    # Find the line containing 'Address:' and extract the IP address
    for line in lines:
        if 'Address:' in line:
            ip_addresses.append(line.split(' ')[-1])  # Extract the last element (the IP address)

    return ip_addresses

# Endpoint to fetch IP addresses with a dynamic domain
@app.get("/get_ip_addresses")
def fetch_ip_addresses(domain: str = Query(..., title="Domain", description="Domain to lookup")):
    ip_addresses = get_ip_addresses(domain)
    print(ip_addresses)
    return {"ip_addresses": ip_addresses}
