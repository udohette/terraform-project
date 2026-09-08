import json
data = '{"app_name": "inventory-service", "port": 8080}'
parsed = json.loads(data)
print(parsed["app_name"])
