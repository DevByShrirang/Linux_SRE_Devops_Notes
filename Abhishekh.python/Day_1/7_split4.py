log = '192.168.1.10 - - [18/Sep/2025:14:32:10] "GET /index.html HTTP/1.1" 200 2326'

# Split by spaces
#parts = log.split()
#print("IP Address:",parts[0])
#print("Timestamp:",parts[3])
My_log= log.split()[0]

print("IP address:", My_log)