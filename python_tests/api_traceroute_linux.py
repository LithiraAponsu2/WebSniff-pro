# from fastapi import FastAPI, Query
# import subprocess

# app = FastAPI()

# def get_ip_addresses(domain):
#     cmd = "traceroute " + domain + " | grep -oE '\\b([0-9]{1,3}\\.){3}[0-9]{1,3}\\b'"
#     result = subprocess.run(
#         cmd,
#         capture_output=True,
#         text=True,
#         shell=True
#     )

#     ip_addresses = list(set(result.stdout.splitlines()[2:]))
#     return ip_addresses

# @app.get("/get_ip_addresses")
# def fetch_ip_addresses(domain: str = Query(..., title="Domain", description="Domain to lookup")):
#     ip_addresses = get_ip_addresses(domain)
#     return {"ip_addresses": ip_addresses}

from fastapi import FastAPI, Query
import subprocess

app = FastAPI()

def get_ip_addresses(domain):
    cmd = "traceroute " + domain + " | grep -oE '\\b([0-9]{1,3}\\.){3}[0-9]{1,3}\\b'"
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        shell=True
    )

    # Filter out IP addresses that start with 192.168
    ip_addresses = [ip for ip in set(result.stdout.splitlines()) if not ip.startswith('192.168')]

    return ip_addresses

@app.get("/get_ip_addresses")
def fetch_ip_addresses(domain: str = Query(..., title="Domain", description="Domain to lookup")):
    ip_addresses = get_ip_addresses(domain)
    return {"ip_addresses": ip_addresses}


