#!/bin/bash

# Ensure you are authenticated in IBM Cloud CLI
# ibmcloud login --apikey <YOUR_API_KEY> -r <REGION>

echo "Starting dry run process..."

# Initialize counters for keys and instances
key_count=0
instance_count=0

# Fetch all object storage instances starting with 'example-'
instances=$(ibmcloud resource service-instances --all-pages | grep -E 'example-.*-infra-image-registry' | awk '{print $1}')

# Check if any instances match
if [[ -z "$instances" ]]; then
  echo "No instances found with the prefix 'example-'"
  exit 0
fi

# Loop through each instance
for instance in $instances; do
  echo "Processing instance: $instance"
  
  # Get keys associated with the instance
  keys=$(ibmcloud resource service-keys --instance-name "$instance" | awk 'NR>3 {print $1}')
  
  # If keys are found, display them and count them
  if [[ -n "$keys" ]]; then
    echo "  Keys to be deleted:"
    for key in $keys; do
      echo "    - $key"
      ((key_count++))  # Increment key count
    done
  else
    echo "  No keys found for instance: $instance"
  fi
  
  # Display the instance deletion (without actually deleting it)
  echo "  Instance to be deleted: $instance"
  ((instance_count++))  # Increment instance count
done

echo "Dry run complete."
echo "Number of instances to be deleted: $instance_count"
echo "Number of keys to be deleted: $key_count"

