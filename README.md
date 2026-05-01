# Dashboard Backup Script

## What it does: This script manages the creation, backup, and deletion of .json files as they relate to exported html dashboard files. These .json files act as backups in case the html dashboards experience any issues. The script also logs each action, such as creating new backups, deleting old backups, and creating checksum values of the .json files for comparison.

## How it works: When the script runs. It loops through all .json files and populates the base file name, the current hash of the file, the stored hash of the file (if one exists) and checks to see if the current hash matches the stored has, if no hash exists one is created, if the hashes exist and are the same nothing happens, and if the hashes differ a new dated folder is created that contains the newer .json file. The checksum for the file is updated to the new version. Lastly, for files more than 3 days old they are deleted 


## Setup: Clone the Repo, create a source directory, script is not executable by default. User will need to run "chmod +x backup.sh" to make executable after cloning. After testing with .json file and verify functionality user will need to add cronjob for specified run times. 



## Requirements: Bash 5+ (Homebrew on macOS) and macOS (uses built in md5 command)

## Project Structure                                                                         
  ```
  dashboard-backups/
  ├── backup.sh          # main script
  ├── backups/           # dated backup folders
  ├── checksums/         # stored md5 hashes
  ├── logs/              # runtime logs       
  ├── .gitignore                          
  └── README.md
  ```
