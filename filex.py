with open("hello.py", "r") as file:
	for line in  file:
		print(line.strip())



with open("output.txt", "w") as file:
	file.write("Hello  using pything dollsdllll\n")
	file.write("testing me \n")

