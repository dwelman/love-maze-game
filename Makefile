# Detect the operating system
ifeq ($(OS),Windows_NT)
    # Windows specific commands
    RM = del /Q /F
    MKDIR = mkdir
    RMDIR = rmdir /S /Q
	LOVE_PATH = "C:\Program Files\LOVE\love.exe"
    SEP = \\
else
    # Unix-like specific commands
    RM = rm -f
    MKDIR = mkdir -p
    RMDIR = rm -rf
	LOVE_PATH = ./love
    SEP = /
endif

# Default target
all: init-submodules

# Initialize submodules
init-submodules:
	git submodule update --init --recursive

# Clean submodules
clean-submodules:
	git submodule deinit -f .
	git submodule update --init --recursive

run:
	$(LOVE_PATH) .

test:
	$(LOVE_PATH) . --test

clean:
	del /Q *.love 

.PHONY: all init-submodules clean-submodules run clean test