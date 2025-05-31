#!/bin/bash

ID="$(kdotool search Horizons)"
window=${ID#*[[:space:]]}

kdotool windowsize $window 1920 1080

