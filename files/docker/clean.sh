# see https://docs.docker.com/engine/install/debian/#uninstall-old-versions

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
