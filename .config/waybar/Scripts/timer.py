#!/usr/bin/env python3

import sys
import json
import time
from datetime import datetime, timedelta
import tkinter as tk
from tkinter import simpledialog, messagebox

CONFIG_FILE = "/home/m57/.config/waybar/timer.json"
TIME_ZONE = "Asia/Amman"
ICON_SIZE = 12
RISE = -2000

def save_config(data):
    with open(CONFIG_FILE, 'w') as f:
        json.dump(data, f)

def load_config():
    try:
        with open(CONFIG_FILE, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return {"status": "READY"}

def get_current_datetime():
    return datetime.now()

def display_timer_status(status_text, tooltip_text):
    print(json.dumps({"text": status_text, "tooltip": tooltip_text}))

def check_timer():
    config = load_config()
    if config['status'] == "READY":
        display_timer_status("<span font='{}' rise='{}'>󰔛</span>".format(ICON_SIZE, RISE), "Timer is not active")
    elif config['status'] == "FINISHED":
        config['status'] = "READY"
        save_config(config)
        messagebox.showinfo("Timer expired!", "Timer expired!")
        display_timer_status("<span font='{}' rise='{}'>󰔛</span>".format(ICON_SIZE, RISE), "")
    else:
        now = get_current_datetime()
        target = datetime.strptime(config['target'], "%Y-%m-%d %H:%M:%S")
        if now >= target:
            config['status'] = "FINISHED"
            save_config(config)
            display_timer_status("<span font='{}' rise='{}'>󰔛</span>".format(ICON_SIZE, RISE), "")
        else:
            remaining = target - now
            tooltip_text = "{}\nRemaining: {}".format(config['title'], str(remaining))
            display_timer_status("<span font='{}' rise='{}'>󰔟</span> {}".format(ICON_SIZE, RISE, config['title']), tooltip_text)

def set_timer():
    root = tk.Tk()
    root.withdraw()
    days = simpledialog.askinteger("Set Timer", "Days (0-365):", minvalue=0, maxvalue=365)
    hours = simpledialog.askinteger("Set Timer", "Hours (0-23):", minvalue=0, maxvalue=23)
    minutes = simpledialog.askinteger("Set Timer", "Minutes (0-59):", minvalue=0, maxvalue=59)
    seconds = simpledialog.askinteger("Set Timer", "Seconds (0-59):", minvalue=0, maxvalue=59)

    if days is None or hours is None or minutes is None or seconds is None:
        messagebox.showerror("Error", "All fields must be filled")
        sys.exit(1)

    target = get_current_datetime() + timedelta(days=days, hours=hours, minutes=minutes, seconds=seconds)
    config = {
        "status": "ACTIVE",
        "target": target.strftime("%Y-%m-%d %H:%M:%S"),
        "title": "Timer"
    }
    save_config(config)
    root.destroy()

def stop_timer():
    config = {"status": "READY"}
    save_config(config)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Invalid command")
        sys.exit(1)

    command = sys.argv[1]
    if command == "check":
        check_timer()
    elif command == "set":
        set_timer()
    elif command == "stop":
        stop_timer()
    else:
        print("Invalid command")
        sys.exit(1)
