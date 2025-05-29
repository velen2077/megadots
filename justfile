# Justfile

nix-flake-update:
    sudo nix --extra-experimental-features 'nix-command flakes' flake update

test-build-endgame-chaotic:
    sudo nix build .#nixosConfigurations.endgame.config.system.build.vm --extra-experimental-features "nix-command flakes" --option 'extra-substituters' 'https://chaotic-nyx.cachix.org/' --option extra-trusted-public-keys "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="

test-build-endgame:
    sudo nix build .#nixosConfigurations.endgame.config.system.build.vm --extra-experimental-features "nix-command flakes"

test-run-endgame:
    rm -f ./endgame.qcow2
    ./result/bin/run-endgame-vm

test-build-flatmate:
    sudo nix build .#nixosConfigurations.flatmate.config.system.build.vm --extra-experimental-features "nix-command flakes"

test-run-flatmate:
    rm -f ./flatmate.qcow2
    ./result/bin/run-flatmate-vm

prod-build-flatmate:
    sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#flatmate --target-host nixos@10.20.100.10

rebuild-flatmate:
    NIX_SSHOPTS="-i /home/velen2077/.ssh/id_ed25519" nixos-rebuild switch --flake .#flatmate --target-host velen2077@10.20.100.10 --use-remote-sudo --option 'extra-substituters' 'https://hyprland.cachix.org/' --option extra-trusted-public-keys "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="

prod-build-endgame:
    sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#endgame --target-host nixos@10.20.1.1

rebuild-endgame:
    sudo nixos-rebuild switch --flake .#endgame

rebuild-update-endgame:
    nix flake update
    sudo nixos-rebuild switch --flake .#endgame

prod-build-nixvm:
    sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#nixvm --target-host nixos@192.168.122.99

rebuild-nixvm:
    NIX_SSHOPTS="-i /home/velen2077/.ssh/id_ed25519" nixos-rebuild switch --flake .#nixvm --target-host velen2077@192.168.122.99 --use-remote-sudo

eval-test:
    nix eval .#nixosConfigurations.nixvm.config.system --extra-experimental-features "nix-command flakes"