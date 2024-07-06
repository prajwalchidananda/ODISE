#!/bin/bash

# Ensure the script stops if any command fails
set -e

# Build the Docker image
docker build -t seg_image .

# Run the Docker container with the specified command
echo "Running the Docker container..."
docker run --rm -v $(pwd)/io:/app/ODISE/io seg_image \
    python demo/demo.py --input $1 --output $2 --vocab "$3" --label "" --binary_mask

echo "Done!"

#docker run --rm -v $(pwd)/io:/app/ODISE/io seg_image \
#    bash -c "source /opt/conda/bin/activate odise && \
#        python demo/demo.py \
#            --input /app/ODISE/input/$1 \
#            --output /app/ODISE/input/$2 \
#            --vocab \"$3\" \
#            --binary_mask"
#