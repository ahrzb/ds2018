.PHONY: help
help: ## prints help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: install_deps
install_deps: ## installs dependencies needed for using project and Makefile commands
	apt install httpie python3 pv

.PHONY: crawl_evand
crawl_evand: ## crawls evand events and saves them to data/evand.json
	@rm -f data/evand.json.part
	@scripts/crawl_evand.sh | pv -l -N "downloading events from evand.com" > data/evand.json.part
	@mv data/evand.json.part data/evand.json
