import json
with open("read_file.py", "r") as file:
	config = json.load(file)
	print(config["app_name"])
	print(config["environment"])
