VENDOR_SWAGGER_SOURCE ?= "https://api.replicated.com/vendor"

install:
	yarn

build:
	`npm bin`/browserify static/js/supportBundleUpload.js > static/js/supportBundleUpload.bundled.js
	yarn gulp
	hugo -v

build_staging:
	`npm bin`/browserify static/js/supportBundleUpload.js > static/js/supportBundleUpload.bundled.js
	yarn gulp
	hugo -v --config config.staging.yaml

serve:
	hugo serve

serve_staging:
	hugo serve --config config.staging.yaml

index-site:
	yarn index-site

index-and-send:
	yarn index-and-send

index-and-send-staging:
	yarn index-and-send-staging

vendordocs:
	rm -f content/docs/reference/vendor-api.md
	git checkout content/docs/reference/vendor-api/index.md
	find . -name "*vendor-api*" -ls
	VENDOR_API="${VENDOR_SWAGGER_SOURCE}" ./vendor.sh

setup:
	mkdir -p java
	curl -o java/swagger2markup-cli-1.3.1.jar http://central.maven.org/maven2/io/github/swagger2markup/swagger2markup-cli/1.3.1/swagger2markup-cli-1.3.1.jar
	curl -o java/swagger2markup-1.3.1.jar http://central.maven.org/maven2/io/github/swagger2markup/swagger2markup/1.3.1/swagger2markup-1.3.1.jar

linkcheck:
	npm install --global broken-link-checker@0.7.8
	time blc http://help.replicated.com -r \
		--host-requests 20 \
		--requests 20 \
		\
		--exclude 'server:8800' \
		--exclude '10.128.0.4' \
		--exclude 'get.company.com/docker' \
		\
		--exclude 'golang.org' \
		--exclude 'circleci.com' \
		--exclude 'registry.replicated.com' \
		--exclude 'registry-data.replicated.com' \
		--exclude 'api.replicated.com' \
		--exclude 'get.replicated.com' \
		\
		--exclude 'help.replicated.com/community' \
		--exclude 'help.replicated.com/tos'  \
		--exlcude 'help.replicated.com/faq' \
		--exclude 'help.replicated.com/privacy' \
		--exclude 'help.replicated.com/guidelines' \
		\
		--color=always  | grep -E 'Getting|Finished|BROKEN|^$$'
