#!/bin/sh

# Using the catppuccin color palette
c_blank='#302d41ff'  # Black 3
c_clear='#c3bac6ff'  # Gray 2
c_ring='#988BA2ff'   # Blue
c_layout='#96cdfbff' # Blue
c_wrong='#f28fadff'  # Red
c_verif='#f8bd96ff'  # Peach
c_typing='#96cdfbff' # Gray 1

# Formatting
time_format="%H:%M:%S" 
date_format="%A, %M. %B"

i3lock                       \
--radius 60                  \
--ind-pos="w/2:h/2"          \
--time-pos="w/2:h/2-200"     \
--date-pos="w/2:h/2-160"     \
--greeter-pos="w/2:h/2"      \
--insidever-color=$c_blank   \
--ringver-color=$c_verif     \
--ring-width=6               \
                             \
--insidewrong-color=$c_blank \
--ringwrong-color=$c_wrong   \
                             \
--inside-color=$c_blank      \
--ring-color=$c_ring         \
--line-color=$c_blank        \
--separator-color=$c_ring    \
                             \
--verif-color=$c_verif       \
--wrong-color=$c_clear       \
--time-color=$c_clear        \
--date-color=$c_clear        \
--layout-color=$c_layout     \
--keyhl-color=$c_typing      \
--bshl-color=$c_wrong        \
                             \
--screen 1                   \
--blur 16                    \
--clock                      \
--indicator                  \
--time-str="$time_format"    \
--date-str="$date_format"    \
--wrong-text="Incorrect!"    \
--verif-text="Verifying"     \
--time-size=75               \
--date-size=30               \
--verif-size=20              \
--wrong-size=20              \

