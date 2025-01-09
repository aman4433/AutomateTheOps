#!/bin/bash

# Ensure you are authenticated in IBM Cloud CLI
# ibmcloud login --apikey <YOUR_API_KEY> -r <REGION>

echo "Starting the deletion process..."

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
  
  # If keys are found, delete them
  if [[ -n "$keys" ]]; then
    echo "  Deleting keys:"
    for key in $keys; do
      echo "    - $key"
      ibmcloud resource service-key-delete "$key" -f
      ((key_count++))  # Increment key count
    done
  else
    echo "  No keys found for instance: $instance"
  fi
  
  # Delete the object storage instance
  echo "  Deleting instance: $instance"
  ibmcloud resource service-instance-delete "$instance" -f
  ((instance_count++))  # Increment instance count
done

echo "Deletion process complete."
echo "Number of instances deleted: $instance_count"
echo "Number of keys deleted: $key_count"

