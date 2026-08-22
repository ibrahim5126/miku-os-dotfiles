#!/usr/bin/env python3
import time
import sys
import psutil
import random

# Miku Palette ANSI Codes
CYAN = "\033[38;2;57;197;187m"
PINK = "\033[38;2;224;43;106m"
WHITE = "\033[97m"
GRAY = "\033[90m"
RESET = "\033[0m"

# Your Custom Braille Miku Artwork
MIKU_ART = r"""
⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣷⣀⡤⠤⠤⠤⠤⢤⣄⣀⡀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣾⣿⣟⡵⠚⠉⠀⠤⠂⠀⠀⠀⠀⠀⠀⠉⠓⠦⣾⣿⣿⣿⡄⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠀⠀⠀⠘⢦⡙⢷⣜⣿⣿⣆⠀⠀⠀
⠀⠀⢺⣿⣿⡟⠁⠀⢀⠀⠀⡆⠀⠀⠀⠀⠀⠈⢣⡀⠀⠀⠀⠙⡼⡍⡘⣿⣿⣆⠀⠀
⠀⠀⠀⢹⡟⠀⠀⢀⠇⢀⡼⡇⠀⠀⠀⣤⡀⠀⠀⢱⡀⠀⠀⠀⠸⣿⡴⡘⣿⣿⣆⠀
⠀⠀⠀⣼⡅⠀⠀⣘⢀⡾⢥⣿⣰⠀⠀⡟⢷⡀⢷⣄⢷⡀⠀⠀⠀⢻⡞⣧⣿⡿⠋⠀
⠀⠀⢠⡿⡇⠀⠀⣽⣾⣤⣤⣈⢿⠆⠀⡇⠘⠹⣿⡝⢮⣇⠀⠀⠀⢸⣿⣿⡟⢱⠀⠀
⠀⠀⢸⠀⡏⡇⠀⣿⢱⠿⣿⣻⡝⢿⣄⢳⢐⣶⣾⣷⣾⣿⠀⠀⡇⠘⣿⠉⡄⠸⡀⠀
⠀⠀⡏⢸⣧⣷⠀⣿⠸⢯⣉⡾⠁⠈⠻⣾⡜⣗⠿⣭⡏⣿⠀⢀⣧⡀⣿⡄⡇⠈⡇⠀
⠀⢠⠇⠸⢱⡟⣆⣿⣄⠀⠀⠀⠀⠀⠀⠈⠁⠑⠖⠚⠀⣾⠀⣼⣿⠙⠇⡇⠇⠀⢇⠀
⠀⢸⠀⠀⢸⠀⠘⢾⣿⣗⣦⣄⣀⠰⠤⠄⠀⠀⣀⣠⢴⢧⠾⠿⠃⠀⠀⡇⠀⠀⢸⠀
⠀⡏⢀⠀⢸⠀⠀⠀⠀⠙⠿⣣⣾⣭⢿⣫⡿⠻⡍⠠⠟⠁⠀⠀⠀⠀⠀⡇⢀⠀⢸⠀
⢠⠁⢸⠀⢸⠀⠀⠀⠀⢀⣴⣿⣧⢸⢿⠇⣵⣼⣿⡄⠀⠀⠀⠀⠀⠀⠀⡇⡎⠀⠘⡇
⢸⠀⠸⡄⡇⠀⠀⠀⣠⣾⣿⣿⡏⣸⣸⠈⠀⢹⣿⣿⣆⠀⠀⠀⠀⠀⠀⡿⡇⠀⠀⡇
⡄⠀⠀⣇⢰⠀⠀⠸⢿⣿⣿⢞⠇⣟⢸⠅⡆⠘⣿⣿⣿⣧⠀⠀⠀⠀⠀⣇⡇⠀⠀⢠
⢁⢆⠀⠸⣼⠀⠀⠘⠋⢩⣾⣧⣶⣿⣿⣆⣼⣿⣿⣿⣻⠿⡄⠀⠀⠀⠀⣿⠁⠐⠀⢸
⠘⡌⣆⠀⢻⡆⠀⠀⠀⠘⠫⣟⣿⣿⣿⣿⣿⣻⣯⠟⠉⠋⠁⠀⠀⠀⢠⡏⢀⠷⠀⢸
⠀⠙⢿⣗⢔⢷⡀⠀⠀⠀⠀⢸⣶⣶⣿⢳⣶⣖⡇⠀⠀⠀⠀⠀⠀⠀⡼⢀⢎⡇⢠⡇
⠀⠀⠀⠙⠻⠲⠽⠄⠀⠀⠀⠀⣿⣿⣿⢸⣿⣿⡇⠀⠀⠀⠀⠀⢀⣞⢔⣃⣼⡴⠋⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⡻⠿⢨⡿⣿⡇⠀⠀⠀⠀⠀⠉⠉⠉⠉⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"""

QUOTES = [
    "Ready to code something legendary!",
    "System is healthy and running fast! 🎵",
    "Don't forget to push your git commits!",
    "Listening to 39 music today? 🎶",
    "Stay hydrated and keep up the great work!",
    "Ubuntu is feeling smooth today!"
]

def render():
    sys.stdout.write("\033[?25l")  # Hide cursor
    try:
        quote = random.choice(QUOTES)
        last_quote_time = time.time()

        while True:
            cpu = psutil.cpu_percent()
            mem = psutil.virtual_memory().percent

            if time.time() - last_quote_time > 7:
                quote = random.choice(QUOTES)
                last_quote_time = time.time()

            # Dynamic expression/status based on CPU load
            if cpu > 75:
                status_text = f"{PINK}Heavy Load! 💦{RESET}"
                miku_comment = "Whoa, things are getting heated up in here!"
            else:
                status_text = f"{WHITE}VOCALOID-01 ACTIVE 🎵{RESET}"
                miku_comment = quote

            # Refresh output
            sys.stdout.write("\033[H\033[2J")
            sys.stdout.write(f"{CYAN}{MIKU_ART}{RESET}\n")
            sys.stdout.write(f"  {PINK}[01 MIKU]{RESET} :: {status_text}\n")
            sys.stdout.write(f"  {CYAN}CPU:{RESET} {cpu:4.1f}%   |   {CYAN}RAM:{RESET} {mem:4.1f}%\n")
            sys.stdout.write(f"  {PINK}Miku:{RESET} \"{miku_comment}\"\n")
            sys.stdout.write(f"\n  {GRAY}(Press Ctrl+C to minimize){RESET}\n")
            sys.stdout.flush()

            time.sleep(1.0)

    except KeyboardInterrupt:
        sys.stdout.write("\033[?25h\033[0m\n")  # Restore cursor and terminal styles
        sys.exit(0)

if __name__ == "__main__":
    render()
