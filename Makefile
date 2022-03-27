DIFF_FILE := /tmp/nix-diff

# Update flakes
update:
	@echo -e "\033[36m==> Updating flakes \033[0m"
	@nix flake update 

# Update and build flake to compare versions of packages 
diff: update
	@echo -e "\033[36m==> Building future configuration \033[0m"
	@sudo nixos-rebuild build
	@echo -e "\033[36m==> Checking the difference \033[0m"
	@nix store diff-closures /nix/var/nix/profiles/system /etc/nixos/result | grep '→' | sed -r 's/(.*),/\1:/' | column -s ':' -t -N 'Package, Version, Size' -o '|' > ${DIFF_FILE}
	@if [ -s ${DIFF_FILE} ]; then\
		bat -p ${DIFF_FILE};\
	else\
		echo -e "\033[36m==> No version changes detected \033[0m";\
	fi
	@rm /etc/nixos/result
	@rm ${DIFF_FILE}


# Switch the configuration
switch:
	@echo -e "\033[36m==> Switching configuration with nixos-rebuild \033[0m"
	@sudo nixos-rebuild switch

upgrade: update switch	
