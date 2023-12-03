# File Deletion Script with Recycle Bin Option

## Overview
This script, created by Kinnto Lee, is a Windows batch file designed to manage file deletion in a specific directory. It offers two modes of operation: Fast Mode and Normal Mode. In Fast Mode, files are permanently deleted, while in Normal Mode, files are safely moved to the Recycle Bin. This allows for recovery if needed.

## Features
- **Two Modes of Operation**: Choose between Fast Mode for quicker deletion or Normal Mode for safer, recoverable deletion.
- **Custom File Extension Selection**: Users can specify a file extension to target specific file types, or choose to affect all files.
- **Progress Display**: The script shows the progress of file deletion, including a percentage complete indicator.

## Prerequisites
- Windows Operating System
- PowerShell (for Normal Mode operation)

## Usage
1. Download the `FileDeletionScript.bat` file.
2. Place it in the directory containing the files you wish to process.
3. Run the script by double-clicking on it or executing it from the command line.
4. Follow the on-screen prompts to choose the operation mode and specify the file extension (if needed).

## Modes
- **Fast Mode**: Files are permanently deleted. This mode is faster but does not allow for file recovery.
- **Normal Mode**: Files are moved to the Recycle Bin. This mode is slower but allows for file recovery.

## Warning
This script involves deleting files, which can be a potentially destructive operation. Always ensure you have backups of important data before running this script. The author is not responsible for any loss of data resulting from the use of this script.

## License
[Specify the license here, if applicable]

## Acknowledgments
- Script created by Kinnto Lee
- Community contributions (if any)

---

For more information, issues, or feature requests, please contact [Your Contact Information or GitHub Profile Link].
