#
.DEFAULT_GOAL := help

# aliases
# alias m='make'

##@ Utility
help: ## Display this help. (Default)
# based on "https://gist.github.com/prwhite/8168133?permalink_comment_id=4260260#gistcomment-4260260"
	@grep -hE '^[A-Za-z0-9_ \-]*?:.*##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

##@ Utility
help_sort: ## Display alphabetized version of help.
	@grep -hE '^[A-Za-z0-9_ \-]*?:.*##.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# set variables with shell scripts
# or manually edit .env and
# remove/comment the following line(s)
# $(shell ./dotenv-gen.sh > /dev/null 2>&1)
# $(shell ./startup-script-gen.sh > /dev/null 2>&1)
include .env
export

env_print: ## Print environment variables including those defined in ".env" file.
	env | grep "GH_\|GCP_"

ghsecrets: ## Update github secrets for GH_REPO from environment vars stored in GH_PAT and GCP_GACD.
	gh secret list --repo=$(GH_REPO)
	gh secret set GOOGLE_APPLICATION_CREDENTIALS_DATA --repo="$(GH_REPO)" --body='$(GCP_GACD)'
	gh secret set PERSONAL_ACCESS_TOKEN --repo="$(GH_REPO)" --body="$(GH_PAT)"
	gh secret set GCP_SERVICE_ACCOUNT --repo="$(GH_REPO)" --body="$(GCP_SERVICE_ACCOUNT)"
	gh secret list --repo=$(GH_REPO)