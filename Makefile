all: up

up:
	./.iron-bank-creds.sh
	#sudo sysctl -w vm.max_map_count=262144
	./init-k3d.sh
	sleep 30
	terraform init
	sleep 30
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
