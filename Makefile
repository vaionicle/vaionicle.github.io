THEME_VERSION=2.6.1
JEKYLL_VERSION=4.2.0
JEKYLL_PATH=/srv/jekyll

wiki.init:
	git submodule init
	git submodule update

wiki.init_1:
	git remote add git-wiki-theme git@github.com:Drassil/git-wiki-theme.git
	git submodule add https://github.com/vaionicle/vaionicle.github.io.wiki.git wiki

wiki.sync:
	./sync-wiki.sh

theme:
	wget https://github.com/Drassil/git-wiki-theme/archive/v${THEME_VERSION}.tar.gz
	tar -xzf v${THEME_VERSION}.tar.gz

	rsync -av ./git-wiki-theme-${THEME_VERSION}/ ./src/

	rm -rf --interactive=never v${THEME_VERSION}.tar.gz
	rm -rf git-wiki-theme-${THEME_VERSION}



build:
	docker run --rm -it --volume="${PWD}/src:${JEKYLL_PATH}" jekyll/jekyll:${JEKYLL_VERSION} jekyll build

serve:
	docker run --rm -it --volume="${PWD}/src:${JEKYLL_PATH}" --name "wiki" \
		-p 4000:4000 \
		-p 35729:35729 \
		jekyll/jekyll:${JEKYLL_VERSION} \
		jekyll serve --force_polling --livereload

ssh:
	docker exec --rm -it --volume="${PWD}/src:${JEKYLL_PATH}" --name "wiki" \
		jekyll/jekyll:${JEKYLL_VERSION} \
		/bin/bash

.PHONY: theme