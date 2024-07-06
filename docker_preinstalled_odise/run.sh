#!/bin/bash

# Ensure the script stops if any command fails
set -e

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_image_path> <output_image_path> <vocabulary>"
    exit 1
fi

# Define input arguments
INPUT_FILE=$1
OUTPUT_FILE=$2
VOCABULARY=$3

# Define the Docker image and container names
IMAGE_NAME="seg_image"
CONTAINER_NAME="seg_container"

# Build the Docker image
docker build -t $IMAGE_NAME .

# Check if the container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container is already running. Executing command..."
else
    # Run the Docker container in detached mode
    docker run -d --name $CONTAINER_NAME -v $(pwd)/io:/app/ODISE/io $IMAGE_NAME tail -f /dev/null
fi

# Print input arguments
echo "Input arguments:"
echo "Input file: $INPUT_FILE"
echo "Output file: $OUTPUT_FILE"
echo "Vocabulary: $VOCABULARY"

# Execute the command in the running container
docker exec $CONTAINER_NAME python demo/demo.py --input $INPUT_FILE --output $OUTPUT_FILE --vocab "$VOCABULARY" --label "" --binary_mask

echo "Done!"
