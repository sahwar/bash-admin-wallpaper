#!/bin/bash

# Къде да бъде запазен тапета
IMAGE_PATH="$HOME/Pictures/Wallpapers/admin_wall.jpg"

# Размер на екрана, пример - 800x600 1024x768 1280x800 ...
SCREEN_SIZE="1024x768"

# Цвят за фона
OLIVE="#9FB04E"
BLUE="#4370AB"
DARK="#000000"

# Цвят за текста
BLACK="black"
WHITE="white"
GREEN="lime"

# Шрифт за текста
# Получи списък на всички шрифтове $ convert -list font
FONT="Courier-Bold"
FONT_SIZE="24"

# Къде точно да се показва текста
# Center|NorthWest|NorthEast|SouthWest|SouthEast|North|West|South|East
GRAVITY="NorthEast"

# Получаване на изхода от $uptime (user friendly)
uptime=$(</proc/uptime)
uptime=${uptime%%.*}

seconds=$(( uptime%60 ))
minutes=$(( uptime/60%60 ))
hours=$(( uptime/60/60%24 ))
days=$(( uptime/60/60/24 ))

# Създаване на тапета
convert -size "$SCREEN_SIZE" xc:"$BLUE" -font "$FONT" -pointsize "$FONT_SIZE" -fill "$WHITE" \
        -gravity "$GRAVITY" -draw "text 50,150 'Kernel: $(uname -r)'" \
        -gravity "$GRAVITY" -draw "text 50,175 'Hostname: $(uname -n)'" \
        -gravity "$GRAVITY" -draw "text 50,200 'Uptime: $(echo "$days days, $hours hours, $minutes minutes, $seconds seconds")'" \
        -gravity "$GRAVITY" -draw "text 50,225 'Date: $(date +'%a-%d-%b,%H:%M')'" "$IMAGE_PATH"

# Сложи като тапет на десктопа
# За Gnome2 също може би MATE
#gconftool-2 -t string -s /desktop/gnome/background/picture_filename "$IMAGE_PATH"
# За Gnome3 и Unity
gsettings set org.gnome.desktop.background picture-uri "$IMAGE_PATH"
# За тези които липсват
#display -size "$SCREEN_SIZE" -window root "$IMAGE_PATH"
