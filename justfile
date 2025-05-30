#  ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗          ██████╗ ██████╗ ███████╗
# ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║         ██╔═══██╗██╔══██╗██╔════╝
# ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║         ██║   ██║██████╔╝███████╗
# ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║         ██║   ██║██╔═══╝ ╚════██║
# ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗    ╚██████╔╝██║     ███████║
#  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═╝     ╚══════╝
                                                                                        
# Update my flake.
update-flake:
    nix --extra-experimental-features 'nix-command flakes' flake update

# ███╗   ██╗██╗██╗  ██╗██╗   ██╗███╗   ███╗     ██████╗ ██████╗ ███████╗
# ████╗  ██║██║╚██╗██╔╝██║   ██║████╗ ████║    ██╔═══██╗██╔══██╗██╔════╝
# ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██╔████╔██║    ██║   ██║██████╔╝███████╗
# ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║╚██╔╝██║    ██║   ██║██╔═══╝ ╚════██║
# ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║ ╚═╝ ██║    ╚██████╔╝██║     ███████║
# ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝     ╚═╝     ╚═════╝ ╚═╝     ╚══════╝

# Perform a clean deploy to nixvm.
nixvm-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#nixvm --target-host nixos@nixvm

# Perform a rebuild of nixvm.
nixvm-rebuild:
    nixos-rebuild switch --flake .#nixvm --target-host velen2077@nixvm --use-remote-sudo

# ███████╗███╗   ██╗██████╗  ██████╗  █████╗ ███╗   ███╗███████╗     ██████╗ ██████╗ ███████╗
# ██╔════╝████╗  ██║██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝    ██╔═══██╗██╔══██╗██╔════╝
# █████╗  ██╔██╗ ██║██║  ██║██║  ███╗███████║██╔████╔██║█████╗      ██║   ██║██████╔╝███████╗
# ██╔══╝  ██║╚██╗██║██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝      ██║   ██║██╔═══╝ ╚════██║
# ███████╗██║ ╚████║██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗    ╚██████╔╝██║     ███████║
# ╚══════╝╚═╝  ╚═══╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝     ╚═════╝ ╚═╝     ╚══════╝
                                                                                         
# Perform a clean deploy to endgame.
endgame-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#endgame --target-host nixos@endgame

# Perform a rebuild of endgame.
endgame-rebuild:
    nixos-rebuild switch --flake .#endgame --target-host velen2077@endgame --use-remote-sudo

# Perform a rebuild of endgame.
endgame-rebuild-locally:
    sudo nixos-rebuild switch --flake .#endgame

# ███████╗██╗      █████╗ ████████╗███╗   ███╗ █████╗ ████████╗███████╗     ██████╗ ██████╗ ███████╗
# ██╔════╝██║     ██╔══██╗╚══██╔══╝████╗ ████║██╔══██╗╚══██╔══╝██╔════╝    ██╔═══██╗██╔══██╗██╔════╝
# █████╗  ██║     ███████║   ██║   ██╔████╔██║███████║   ██║   █████╗      ██║   ██║██████╔╝███████╗
# ██╔══╝  ██║     ██╔══██║   ██║   ██║╚██╔╝██║██╔══██║   ██║   ██╔══╝      ██║   ██║██╔═══╝ ╚════██║
# ██║     ███████╗██║  ██║   ██║   ██║ ╚═╝ ██║██║  ██║   ██║   ███████╗    ╚██████╔╝██║     ███████║
# ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝     ╚═════╝ ╚═╝     ╚══════╝

# Perform a clean deploy to flatmate.
flatmate-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#flatmate --target-host nixos@flatmate

# Perform a rebuild of flatmate.
flatmate-rebuild:
    nixos-rebuild switch --flake .#flatmate --target-host velen2077@flatmate --use-remote-sudo