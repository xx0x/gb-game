# Makefile for GameBoy Game

# Set the assembler and linker
ASM = rgbasm
LINKER = rgblink
FIXER = rgbfix

# Set the source directory and output name
SRC_DIR = src
BUILD_DIR = build
ROM_NAME = gb-game

# Set flags for rgbasm
ASM_FLAGS = -E

# Set flags for rgbfix (Nintendo logo, title, etc.)
FIX_FLAGS = -v -p 0 -t "GB GAME" -j -m 0x00

# Find all ASM files in the src directory
SRC_FILES = $(SRC_DIR)/main.asm

# Create object file paths
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)/%.asm=$(BUILD_DIR)/%.o)

# Default target
all: $(BUILD_DIR)/$(ROM_NAME).gb

# Create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile .asm files to .o files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(ASM) $(ASM_FLAGS) -o $@ $<

# Link .o files to .gb file
$(BUILD_DIR)/$(ROM_NAME).gb: $(OBJ_FILES)
	$(LINKER) -o $(BUILD_DIR)/$(ROM_NAME).gb $(OBJ_FILES)
	$(FIXER) $(FIX_FLAGS) $(BUILD_DIR)/$(ROM_NAME).gb

# Clean build files
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean