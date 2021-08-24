all: up

up:
	./init-k3d.sh
	terraform init
	terraform apply --auto-approve

down:
	k3d cluster delete big-bang-quick-start
	rm terraform.tfstate