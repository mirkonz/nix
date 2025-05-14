autoload colors;
colors
fg[brown]='\033[38;5;130m'

function random_icon() {
    local icons=(
        "$fg[green]\ue2a2$reset_color" # Palm tree
        "$fg[brown]\uf0f4$reset_color" # Coffee
        "$fg[yellow]\ude4a$reset_color" # Fingers crossed
        "$fg[red]\uf5fd$reset_color" # Fire
        "$fg[green]\uf55c$reset_color" # Alien
        "$fg[white]\uf313$reset_color" # Moon
        "$fg[yellow]\uf314$reset_color" # Sun
        "$fg[blue]\uf327$reset_color" # Rocket
        "$fg[blue]\uf435$reset_color" # Dog
        "$fg[blue]\uf6a0$reset_color" # Cat
        "$fg[white]\uf6d3$reset_color" # Cow
        "$fg[green]\uf6c3$reset_color" # Frog
        "$fg[black]\uf700$reset_color" # Crow
        "$fg[cyan]\uf11b$reset_color" # Gamepad
        "$fg[red]\uf2c8$reset_color" # Thermometer
        "$fg[cyan]\uf233$reset_color" # Server
        "$fg[cyan]\uf108$reset_color" # Computer
        "$fg[yellow]\uf6de$reset_color" # Cheese
        "$fg[yellow]\uf6d0$reset_color" # Pizza
        "$fg[magenta]\uf6cc$reset_color" # Ice Cream
        "$fg[white]\uf75f$reset_color" # Skull
        "$fg[red]\uf4a5$reset_color" # Explosion
    )
    echo -e "${icons[$RANDOM % ${#icons[@]}]}"
}
