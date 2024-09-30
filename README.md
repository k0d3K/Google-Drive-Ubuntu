## Automatic File Monitoring and Synchronization with rclone -- Lucien Guerbigny

This document explains how to use a script to automatically monitor a folder for changes and trigger synchronization with your Google Drive using rclone.

**Prerequisites:**

* Linux system with `rclone` and `inotifywait` installed.
* rclone configured with your Google Drive account credentials.

**Files:**

* `monitor.sh`: The script that monitors the folder and triggers synchronization.

**Steps:**

1. **Configure rclone:**
   * Follow the official rclone documentation ([https://rclone.org/commands/rclone_config/](https://rclone.org/commands/rclone_config/)) to set up rclone and connect it to your Google Drive account.
   * Make sure you remember the name you assigned to your Google Drive remote during configuration (e.g., `remote:MyDrive`).

2. **Customize the script (optional):**
   * Open `monitor.sh` in a text editor.
   * Replace the following placeholders with your desired values:
     * `folder_to_monitor`: The path to the folder you want to monitor.
     * `rclone_command`: Your rclone sync command.  For example, to synchronize the entire folder:
       ```
       rclone sync "$folder_to_monitor" remote:MyDrive
       ```
     * You can modify the `rclone_command` to synchronize specific files or subfolders within the monitored folder.

3. **Make the script executable:**
   * Open a terminal window and navigate to the directory containing the script.
   * Run the following command:

     ```bash
     chmod +x monitor.sh
     ```

4. **Start the script:**
   * In the terminal, run the script with the following command:

     ```bash
     ./monitor.sh
     ```

     * This will start the script in the foreground, continuously monitoring the folder for changes.

5. **Stop the script:**
   * **Interrupt the script:** If the script is running in the terminal window, press `Ctrl+C` to stop it.
   * **Terminate the process:** If the script is running in the background, you can find its process ID (PID) using the `ps` command and then terminate it using the `kill` command. For example:

     ```bash
     # Find the PID
     ps aux | grep monitor.sh

     # Terminate the process with PID 1234 (replace with actual PID)
     kill 1234
     ```

**Explanation:**

* The script uses `inotifywait` to monitor the specified folder for any changes (creation, modification, or deletion of files).
* Whenever a change occurs, the script triggers the `rclone_command` you defined, which synchronizes the contents of the folder with your Google Drive.

**Additional Notes:**

* This script monitors all files within the specified folder. You can modify the `rclone_command` to focus on specific files or subfolders.
* Consider adding error handling to the script to capture and log potential issues.
* For very large folders or high-traffic environments, you might need to optimize the script or explore alternative approaches.

**By following these steps and customizing the script, you can automate the process of synchronizing your files with Google Drive whenever changes occur.**
