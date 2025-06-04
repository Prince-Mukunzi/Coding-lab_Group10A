## 🏥 Hospital Data Monitoring & Archival System

## Overview

This project simulates real-time monitoring of hospital data (heart rate, temperature, and water usage), and allows manual log archiving and data analysis using shell scripts.

## How It Works

### 1. Start Monitoring (in separate terminals)

- python3 heart_rate_monitor.py start
- python3 temperature_recorder.py start
- python3 water_consumption.py start
Logs are saved in the active_logs/ folder.

### 2. Archive Logs (./archive_logs.sh)
- Choose which log to archive.
- Script moves it to the right archive folder with a timestamp.
- Creates a new empty log file.

### 3. Analyze Logs (./analyze_logs.sh)
- Choose which log to analyze.
- Script counts entries per device and shows first/last timestamps.
- Results saved in reports/analysis_report.txt.

### 4. Files
- archive_logs.sh: Script to archive logs
- analyze_logs.sh: Script to analyze logs
- heart_rate_monitor.py, temperature_recorder.py, water_consumption.py: Simulators

### 5. Stop Monitoring (Run the following commands in their respective terminals to stop the running programs)
- python3 heart_rate_monitor.py stop
- python3 temperature_recorder.py stop
- python3 water_consumption.py stop

IMPORTANT: I modified the python simulators log directory named from LOG_DIR = "active_logs"  to LOG_DIR=hospital/active_logs" this was messing up the structure of the system.