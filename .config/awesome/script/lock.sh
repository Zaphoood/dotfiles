#!/bin/sh

# Using the catppuccin color palette
B='#302d41ff'  # blank:     Black 3
C='#c3bac6ff'  # clear:     Gray 2
D='#988BA2ff'  # typing:    Blue
T='#96cdfbff'  # text:      Blue
W='#f28fadff'  # wrong:     Red
V='#f8bd96ff'  # verifying: Peach
VT='#96cdfbff' # default:   Gray 1

# Formatting
time_format="%H:%M:%S" 
date_format="%A %M %B"

i3lock                    \
--radius 60               \
--ind-pos="w/2:h/2"       \
--time-pos="w/2:h/2-200"  \
--date-pos="w/2:h/2-160"  \
--greeter-pos="w/2:h/2"   \
--insidever-color=$B      \
--ringver-color=$V        \
--ring-width=6            \
                          \
--insidewrong-color=$W    \
--ringwrong-color=$C      \
                          \
--inside-color=$B         \
--ring-color=$D           \
--line-color=$B           \
--separator-color=$D      \
                          \
--verif-color=$VT         \
--wrong-color=$C          \
--time-color=$C           \
--date-color=$C           \
--layout-color=$T         \
--keyhl-color=$VT         \
--bshl-color=$W           \
                          \
--screen 1                \
--blur 16                 \
--clock                   \
--indicator               \
--time-str=$time_format   \
--date-str=$date_format   \
--wrong-text="incorrect!" \
--verif-text="verifying"  \
--time-size=75            \
--date-size=30            \
--verif-size=20           \
--wrong-size=20           \

