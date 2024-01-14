from fastapi import FastAPI, Query
import subprocess

app = FastAPI()

def get_ip_addresses(domain):
    # Run the tracert command with the provided domain
    cmd = f"tracert {domain}"
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        shell=True
    )

    ip_addresses = []

    # Split the output by lines
    lines = result.stdout.split('\n')

    # Find lines with IP addresses and extract them
    for line in lines:
        if "[" in line and "]" in line:
            ip = line.split("[")[1].split("]")[0]
            ip_addresses.append(ip)

    return ip_addresses

# Endpoint to fetch IP addresses with a dynamic domain
@app.get("/get_ip_addresses")
def fetch_ip_addresses(domain: str = Query(..., title="Domain", description="Domain to lookup")):
    ip_addresses = get_ip_addresses(domain)
    print(ip_addresses)
    return {"ip_addresses": ip_addresses}
