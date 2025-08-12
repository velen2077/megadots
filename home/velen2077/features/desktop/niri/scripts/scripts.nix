{pkgs, ...}: let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    # If an argument is passed, execute the command and exit
    if [ "$#" -gt 0 ]; then
        case $1 in
            shutdown)
                shutdown now
                ;;
            reboot)
                reboot
                ;;
            lock)
                pidof hyprlock || hyprlock
                ;;
            logout)
                niri msg action quit --skip-confirmation
                ;;
        esac
        # Exit without output to make rofi close
        exit 0
    fi

    # If no arguments, show the menu
    declare -A options

    options[shutdown]=system-shutdown
    options[reboot]=system-reboot
    options[lock]=system-lock-screen
    options[logout]=system-log-out

    for key in "''${!options[@]}"
    do
        echo -en "$key\0icon\x1f''${options[$key]}\n"
    done
  '';
  cpu-temp = pkgs.writeShellScriptBin "cpu-temp" ''
    get_cpu_temp() {
        temp=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/[^0-9.]*//g' | head -1)

        if [ -z "$temp" ]; then
            temp=$(sensors | grep 'Package id' | awk '{print $4}' | sed 's/[^0-9.]*//g' | head -1)
        fi

        if [ -z "$temp" ]; then
            temp=$(sensors | grep 'Core [0-9]*:' | head -1 | awk '{print $3}' | sed 's/[^0-9.]*//g')
        fi

        echo "$temp"
    }

    temp=$(get_cpu_temp)
    temp=''${temp%.*}  # Remove decimal part if present

    echo "{\"text\":\"$temp\"}"
  '';
  gpu-temp = pkgs.writeShellScriptBin "gpu-temp" ''
    get_gpu_temp() {
        if command -v nvidia-smi >/dev/null 2>&1; then
            temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            if [ -n "$temp" ] && [ "$temp" != "0" ]; then
                echo "$temp"
                return
            fi
        fi

        temp=$(sensors | awk '/edge/ {if (!found) {print int($2); found=1}}')

        if [ -z "$temp" ]; then
            temp=$(sensors | grep -i 'gpu' | awk '{print $2}' | sed 's/[^0-9.]*//g' | head -1)
        fi

        if [ -z "$temp" ]; then
            temp=$(sensors | grep 'Core [0-9]*:' | awk '{print $3}' | sed 's/[^0-9.]*//g' | sort -nr | head -1)
        fi

        echo "$temp"
    }

    temp=$(get_gpu_temp)

    if [ -z "$temp" ] || [ "$temp" = "0" ]; then
        echo "{\"text\":\"N/A\"}"
        exit 0
    fi

    echo "{\"text\":\"$temp\"}"
  '';
in {home.packages = [powermenu cpu-temp gpu-temp];}
