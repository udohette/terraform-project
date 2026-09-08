#!/usr/bin/env python3
import sys

print("Hello from Python")

if True:
    print("This runs")


name = "DevOps Student"
course = "Python Fundamentals"
day = 1

print(name)
print(course)
print(day)



environments = ["local","dev", "staging", "production"]
print(environments)
print(environments[0])


for env in environments:
    print(env)


servers = ["web-1", "web-2", "db-1"]
for server in servers:
    print(f"Checking {server}")




config = {
"app_name": "inventory-service",
"port": 8080,
"environment": "staging"
}


print(config["app_name"])
print(config["port"])



server = {
"name": "web-1",
"ip": "192.168.1.10",
"role": "frontend"
}
print(f"{server['name']} -> {server['ip']}")



print(sys.argv)
