#!/bin/bash

# Function to display menu
show_menu() {
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    echo -n "Enter choice (1-3): "
}

# Function to validate input
validate_input() {
    case $1 in
        1|2|3) return 0 ;;
        *) return 1 ;;
    esac
}

# Function to analyze log file
analyze_log() {
    local log_file="$1"
    local log_type="$2"
    
    # Check if log file exists
    if [ ! -f "$log_file" ]; then
        echo "Error: Log file $log_file not found!"
        return 1
    fi
    
    # Check if log file is empty
    if [ ! -s "$log_file" ]; then
        echo "Warning: Log file $log_file is empty!"
        return 1
    fi
    
    echo "Analyzing $log_type log file..."
    
    # Create reports directory if it doesn't exist
    mkdir -p reports
    
    # Generate timestamp for report
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Start analysis report section
    echo "========================================" >> reports/analysis_report.txt
    echo "Analysis Report - $log_type" >> reports/analysis_report.txt
    echo "Generated: $timestamp" >> reports/analysis_report.txt
    echo "========================================" >> reports/analysis_report.txt
    
    # Count occurrences of each device
    echo "Device Statistics:" >> reports/analysis_report.txt
    awk '{print $3}' "$log_file" | sort | uniq -c | sort -nr | while read count device; do
        echo "  $device: $count entries" >> reports/analysis_report.txt
    done
    
    # Get first and last entry timestamps (bonus feature)
    local first_entry=$(head -n 1 "$log_file" | awk '{print $1, $2}')
    local last_entry=$(tail -n 1 "$log_file" | awk '{print $1, $2}')
    
    echo "" >> reports/analysis_report.txt
    echo "Time Range:" >> reports/analysis_report.txt
    echo "  First Entry: $first_entry" >> reports/analysis_report.txt
    echo "  Last Entry: $last_entry" >> reports/analysis_report.txt
    echo "" >> reports/analysis_report.txt
    
    echo "Analysis complete! Results appended to reports/analysis_report.txt"
}

# Main script execution
main() {
    # Display menu and get user input
    show_menu
    read choice
    
    # Validate input
    if ! validate_input "$choice"; then
        echo "Error: Invalid choice. Please enter 1, 2, or 3."
        exit 1
    fi
    
    # Set log file path and type based on choice
    case $choice in
        1)
            log_file="hospital_data/active_logs/heart_rate_log.log"
            log_type="Heart Rate"
            ;;
        2)
            log_file="hospital_data/active_logs/temperature_log.log"
            log_type="Temperature"
            ;;
        3)
            log_file="hospital_data/active_logs/water_usage_log.log"
            log_type="Water Usage"
            ;;
    esac
    
    # Analyze the selected log file
    analyze_log "$log_file" "$log_type"
}

# Run main function
main