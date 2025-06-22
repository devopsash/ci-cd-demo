import yaml
import logging
from datetime import datetime

# Configure logging
log_file = "yaml_check.log"
logging.basicConfig(
    filename=log_file,
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

def log_and_print(message):
    print(message)
    logging.info(message)

def send_email_alert(subject, body):
    # Dummy email alert simulation
    alert_message = f"[Email Trigger] Subject: {subject} | Body: {body}"
    log_and_print(alert_message)
    # In real use, you can uncomment and configure actual email sending
    # See previous example for full email setup
    # log_and_print("[Email sent]")

def process_yaml(yaml_file_path):
    try:
        with open(yaml_file_path, 'r') as file:
            data = yaml.safe_load(file)
    except Exception as e:
        logging.error(f"Failed to load YAML file: {e}")
        return

    if not isinstance(data, dict):
        log_and_print("YAML file does not have a dictionary structure.")
        return

    swap_found = False
    log_and_print(f"\nProcessing YAML File: {yaml_file_path}")

    for heading, children in data.items():
        log_and_print(f"\nHeading: {heading}")
        if isinstance(children, dict) and children:
            for child in children:
                log_and_print(f"  - {child}")
                if child == 'swap':
                    swap_found = True
        else:
            log_and_print("  - empty child")

    if swap_found:
        send_email_alert(
            subject="YAML Alert: 'swap' key detected",
            body=f"The YAML file '{yaml_file_path}' contains a child key named 'swap'."
        )
    else:
        log_and_print("No 'swap' key found in YAML.")

# Example usage
if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python print_yaml_with_logging.py <path_to_yaml_file>")
    else:
        process_yaml(sys.argv[1])
