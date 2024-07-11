GPC=gpc

UNIT_PATH=src/modules
UNIT_DESTINATION=build/modules
OBJECT_DESTINATION=build
EXECUTABLE_PATH=bin

MAIN_PROGRAM=src/Main.pas

GPCFLAGS=--stack-checking --range-checking --io-checking --no-macros --no-short-circuit --no-ignore-packed --no-methods-always-virtual --no-implicit-result -Wwarnings -Wall -g -v -Wl,--strip-all -time --extended-pascal -O3 --executable-file-name --automake --unit-path=$(UNIT_PATH) --unit-destination-path=$(UNIT_DESTINATION) --object-destination-path=$(OBJECT_DESTINATION) --executable-path=$(EXECUTABLE_PATH)


all: src/Main.pas
	@echo "Compilation"
	mkdir -p build/modules
	mkdir -p bin
	$(GPC) $(GPCFLAGS) $(MAIN_PROGRAM)

clean: 
	@echo "Removing all but source code files"
	rm -rf bin
	rm -rf build
	
