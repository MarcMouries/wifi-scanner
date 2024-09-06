#!/bin/bash

# Paths
SRC_DIR="./src"
BUILD_DIR="./dist"
SRC_FILE="wifi_scanner.m"
OUTPUT_BINARY="wifi_scanner"

# Check if build directory exists, if not, create it
if [ ! -d "$BUILD_DIR" ]; then
  mkdir "$BUILD_DIR"
fi

# Compile the source file
clang -framework CoreWLAN -framework Foundation -o "$BUILD_DIR/$OUTPUT_BINARY" "$SRC_DIR/$SRC_FILE"

# Check if compilation was successful
if [ $? -eq 0 ]; then
  echo "Compilation successful. Running the program..."
  # Run the compiled binary
  "$BUILD_DIR/$OUTPUT_BINARY"
else
  echo "Compilation failed."
fi
