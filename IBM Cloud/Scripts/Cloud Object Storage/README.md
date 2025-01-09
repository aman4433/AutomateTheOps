# IBM Cloud Object Storage (COS) Operations

This directory contains scripts for managing and automating operations related to IBM Cloud Object Storage (COS). It is a growing collection of utilities aimed at simplifying resource management and optimizing COS usage.

---

## 📂 Current Scripts

### 1. **Dry Run COS Cleanup Script**
- **Description**: Simulates the cleanup process by identifying COS instances and their associated keys based on a specific naming pattern (e.g., `example-*`). This ensures the correct resources are targeted before proceeding with deletion.
- **Purpose**: Helps verify selected instances and keys to avoid unintended deletions.

### 2. **COS Cleanup Script**
- **Description**: Deletes the specified COS instances and their associated keys. This script is used after verifying the resources through the dry run.
- **Purpose**: Automates the cleanup process for obsolete or unnecessary COS resources.
- **Caution**: This operation is irreversible; ensure you’ve reviewed the resources carefully.

---

## 🛠️ How to Use These Scripts

1. **Authenticate with IBM Cloud CLI**:
   Ensure you are logged in with the appropriate credentials and permissions:
   ```bash
   ibmcloud login --apikey <YOUR_API_KEY> -r <REGION>
Run the Scripts:

Use the Dry Run Script to validate the targeted instances and keys:
bash
Copy code
./dry_run_cleanup.sh
Once validated, use the Cleanup Script to delete the selected resources:
bash
Copy code
./cos_cleanup.sh
Check Logs: Monitor the console output for details about the processed instances and keys.

🔄 Continuous Updates
This repository will be regularly updated with new scripts and features to support various COS operations, such as:

Creating and managing resources
Enhanced resource monitoring
Advanced filtering for selective cleanup
Usage analytics and reporting
If you have suggestions or face any issues, feel free to contribute or raise them to improve these utilities.

---

⚠️ Disclaimer:

These scripts are provided as-is. Use them cautiously, especially for deletion tasks. Always run the dry run script to confirm the targeted resources before executing irreversible operations.

