THEME_VERSION=2.6.1
JEKYLL_VERSION=4.2.0
JEKYLL_PATH=/srv/jekyll

wiki.init:
	git submodule init
	git submodule update

wiki.add:
	git submodule add --name vaionicles-wiki https://github.com/vaionicle/vaionicle.github.io.wiki.git wiki

wiki.sync:
	./sync-wiki.sh

clean:
	rm -rf ${PWD}/_site

theme:
	wget https://github.com/Drassil/git-wiki-theme/archive/v${THEME_VERSION}.tar.gz
	tar -xzf v${THEME_VERSION}.tar.gz

	rsync -av ./git-wiki-theme-${THEME_VERSION}/ ./src/

	rm -rf --interactive=never v${THEME_VERSION}.tar.gz
	rm -rf git-wiki-theme-${THEME_VERSION}

	rsync -av ./overrides/ ./src/

build: clean
	docker run --rm -it --name "wiki" \
		--volume="${PWD}:${JEKYLL_PATH}" \
		--volume="${PWD}/.bundle:/usr/local/bundle" \
		jekyll/jekyll:${JEKYLL_VERSION} jekyll build

serve:
	mkdir -p ${PWD}/.vendor/bundle
	docker run --rm -it --name "wiki" \
		--volume="${PWD}/.vendor/bundle:/usr/local/bundle" \
		--volume="${PWD}:${JEKYLL_PATH}"  \
		-p 4000:4000 \
		-p 35729:35729 \
		jekyll/jekyll:${JEKYLL_VERSION} \
		jekyll serve --force_polling --livereload

ssh:
	docker exec --rm -it --volume="${PWD}:${JEKYLL_PATH}" --name "wiki" \
		jekyll/jekyll:${JEKYLL_VERSION} \
		/bin/bash

.PHONY: theme