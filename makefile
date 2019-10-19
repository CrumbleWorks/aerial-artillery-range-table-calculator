stack = stack

run:
	$(stack) build --fast && $(stack) exec aartc-exe
