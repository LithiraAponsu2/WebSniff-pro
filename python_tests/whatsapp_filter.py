import subprocess

# Run the nslookup command and capture the output
result = subprocess.run('nslookup -type=A web.whatsapp.com | findstr "Address"', capture_output=True, text=True, shell=True)

ip_address = []

# Split the output by lines
lines = result.stdout.split('\n')
print(lines)
# Find the line containing 'Address:' and extract the IP address
for i, line in enumerate(lines):
    if 'Address:' in line:
        ip_address.append(line.split(' ')[-1])  # Extract the last element (the IP address)
        
print(ip_address)
print(f'My IP: {ip_address[0]}')
print(f'Whatsapp IP: {ip_address[1]}')