import pyautogui
import pyperclip
import time

# Prompt user for loop count
loop_count = pyautogui.prompt(text='Please enter the desired loop amount.', title='Loop Amount')

# Validate the input
if loop_count is None or not loop_count.isdigit():
    print("No valid input provided. Exiting...")
else:
    loop_count = int(loop_count)

    for _ in range(loop_count):
        # Perform a left-click at the specified position (250, 220)
        pyautogui.click(250, 220)
        time.sleep(0.5)

        # Coordinates for the repetitive clicks
        positions = [(1360, 485), (857, 676)]
        for _ in range(10):  # Loop for the repeated click pattern
            for pos in positions:
                pyautogui.click(pos[0], pos[1])
                time.sleep(0.25)

        # Perform the copy operation
        pyautogui.click(691, 700)
        pyautogui.click(691, 700)
        time.sleep(0.1)
        pyautogui.hotkey('ctrl', 'c')
        time.sleep(0.25)

        # Perform the paste operation
        pyautogui.click(691, 720)
        time.sleep(0.1)
        pyautogui.hotkey('ctrl', 'v')
        time.sleep(0.25)
        pyautogui.click(691, 740)
        time.sleep(0.25)
