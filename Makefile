DEFAULT_GOAL := help

help: ## ヘルプを表示する
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## terraform initを実行
	@terraform init

plan: ## terraform planを実行
	@terraform plan

dplan: ## terraform plan -destroyを実行
	@terraform plan -destroy

fmt: ## terraform fmtを実行
	@terraform fmt

apply: ## terraform applyを実行
	@terraform apply

refresh: ## terraform refreshを実行
	@terraform refresh

destroy: ## terraform destroyを実行
	@terraform destroy

.PHONY: help init plan fmt apply destroy
