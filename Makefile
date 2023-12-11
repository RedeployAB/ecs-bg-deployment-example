.DEFAULT_GOAL := help

# Commands
TF_ROOT_DIR := terraform
TERRAFORM = terraform -chdir=$(TF_ROOT_DIR)

# Variables
PROFILE ?= $(AWS_PROFILE)

PROJECT := $(shell basename $(PWD))

PLANFILE ?= $(PROJECT).plan

# Targets

## lint.fmt: Validate terraform and running terraform fmt
.PHONY: lint.fmt
lint.fmt:
	$(call blue, "# Validate terraform and running terraform fmt...")
	@$(TERRAFORM) fmt -check -diff -recursive .
	@$(TERRAFORM) validate $(TF_DIR)

## lint.tflint: Run tflint
.PHONY: lint.tflint
lint.tflint:
	$(call blue, "# Running tflint...")
	@tflint ${TF_ROOT_DIR}

## lint.tf: Run lint terraform code
lint.tf: lint.fmt lint.tflint

## deploy.tf: Initialize, plan and apply Terraform code
.PHONY: deploy.tf
deploy.tf: plan.tf apply.tf

## init.tf: Initialize terraform state backend and providers
.PHONY: init.tf
init.tf:
	@rm -f $(TF_ROOT_DIR)/.terraform/terraform.tfstate
	@$(TERRAFORM) init -upgrade

## plan.tf: Runs a terraform plan
.PHONY: plan.tf
plan.tf: init.tf lint.tf
	$(call blue,"# Running terraform plan...")
	@rm -f "$(PLANFILE)"
	@$(TERRAFORM) plan -input=false -refresh=true $(PLAN_ARGS) -out="$(PLANFILE)"

## apply.tf: Applies a planned state.
.PHONY: apply.tf
apply.tf::
	$(call blue,"# Running terraform apply...")
	@if [ ! -r "${TF_ROOT_DIR}/$(PLANFILE)" ]; then echo "You need to plan first!" ; exit 14; fi
	@$(TERRAFORM) apply -input=true -refresh=true "$(PLANFILE)"

## destroy.tf: Destroy resources created by terraform.
.PHONY: destroy.tf
destroy.tf::
	$(call blue,"# Running terraform destroy...")
	@if [ ! -r "${TF_ROOT_DIR}/$(PLANFILE)" ]; then echo "You need to plan first!" ; exit 14; fi
	@$(TERRAFORM) destroy

## doc: Generate terraform documentation
.PHONY: doc
doc:
	$(call blue,"# Generating terraform documentation...")
	cd $(TF_ROOT_DIR) && terraform-docs markdown . --recursive --output-file README.md

## help: prints this help message
.PHONY: help
help: Makefile
	@echo
	$(call blue, " Choose a command run:")
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

# -- Helper Functions --
define blue
	@tput setaf 4
	@echo $1
	@tput sgr0
endef
