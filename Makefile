all: up

up:
	./init-k3d.sh
	terraform init
	terraform apply --auto-approve

down:
	k3d cluster delete big-bang-quick-start
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup

clean:
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup
	rm -rf ~/.dod-platform-one-big-bang-cache/
	rm -rf .terraform/
	rm -f .terraform.lock.hcl
