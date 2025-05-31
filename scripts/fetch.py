import random
import os

def main():
    filename = '/home/tyler/.dotfiles/data/logos'
    with open(filename, 'r') as file:
        lines = [line.rstrip() for line in file]

        index = random.randint(1, len(lines) - 2)

        line = lines[index]

        parts = line.split('"')
        logo = parts[1]

        print(f'Using {logo}')
        os.system(f'fastfetch -l "{logo}"')

if __name__ == "__main__":
    main()
