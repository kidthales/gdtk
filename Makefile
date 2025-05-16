# Executables (local)
BAKE = docker buildx bake

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build toolkit with-aseprite

## —— 🔧 👾 Game Development Toolkit Makefile 👾 🔧 ———————————————————————————————
help: ## Outputs this help screen.
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

build: ## Build images. Pass the parameter "c=" to add options to docker buildx bake; example: make build c="toolkit with-aseprite --no-cache --pull"
	@$(eval c ?=)
	@$(BAKE) $(c)

toolkit: ## Build toolkit image. Pass the parameter "c=" to add options to docker buildx bake; example: make toolkit c="--no-cache --pull"
	@$(eval c ?=)
	@$(BAKE) toolkit $(c)

with-aseprite: ## Build toolkit image with aseprite included. Pass the parameter "c=" to add options to docker buildx bake; example: make with-aseprite c="--no-cache --pull"
	@$(eval c ?=)
	@$(BAKE) with-aseprite $(c)
