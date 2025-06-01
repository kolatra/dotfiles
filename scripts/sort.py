#!/usr/bin/python3
import os

types = {
    "jpg": "Pictures",
    "png": "Pictures",
    "jpeg": "Pictures",
    "gif": "Pictures",
    "iso": "isos",
    "zip": "archives",
    "tar": "archives",
    "gz": "archives",
    "jar": "archives",
    "flatpakref": "software",
    "AppImage": "software",
    "bundle": "software",
    "rpm": "software",
}

def main():
    directory = os.fsencode("/home/tyler/Downloads")

    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        if os.path.isdir(filename):
            continue

        extension = filename.split(".")[-1]
        if extension not in types:
            print("[!] Unknown extension {}\n  - File: {}".format(extension, filename))
            continue
        destination = types[extension]
        os.rename("/home/tyler/Downloads/{}".format(filename), "/home/tyler/{}/{}".format(destination, filename))

if __name__ == "__main__":
    main()
