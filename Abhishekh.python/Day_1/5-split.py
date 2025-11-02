log = '192.168.1.10 - - [18/Sep/2025:14:32:10] "GET /index.html HTTP/1.1" 200 2326'

# Split by spaces
#parts = log.split()
#print(parts)

ip_address = log.split()[0]
print("IP address:", ip_address)

timestamp = log.split()[3]
print("TIMESTAMP:", timestamp)
