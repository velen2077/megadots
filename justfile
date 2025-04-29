# Justfile

build-test:
    sudo nix build .#nixosConfigurations.endgame.config.system.build.vm --extra-experimental-features "nix-command flakes"

build-test-with-chaotic:
    sudo nix build .#nixosConfigurations.endgame.config.system.build.vm --extra-experimental-features "nix-command flakes" --option 'extra-substituters' 'https://chaotic-nyx.cachix.org/' --option extra-trusted-public-keys "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
run-test:
    rm -f ./endgame.qcow2
    ./result/bin/run-endgame-vm
eval-test:
    sudo nix eval .#nixosConfigurations.endgame.config.system.build.vm --extra-experimental-features "nix-command flakes"

test-build-flatmate:
    sudo nix build .#nixosConfigurations.flatmate.config.system.build.vm --extra-experimental-features "nix-command flakes"

test-run-flatmate:
    rm -f ./flatmate.qcow2
    ./result/bin/run-flatmate-vm