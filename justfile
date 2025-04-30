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
    sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#flatmate --target-host nixos@10.20.100.50