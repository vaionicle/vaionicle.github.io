JEKYLL_VERSION=4.0
JEKYLL_PATH=/srv/jekyll

wiki.init:
	git submodule init
	git submodule update

wiki.init_1:
	rm -rf wiki
	git remote add git-wiki-source git@github.com:Drassil/git-wiki.git
	git submodule add https://github.com/vaionicle/vaionicle.github.io.wiki.git wiki

wiki.sync:
	./sync-wiki.sh

build:
	docker run \
		--rm -it \
		--volume="${PWD}:${JEKYLL_PATH}" \
		jekyll/jekyll:${JEKYLL_VERSION} \
		jekyll build

serve:
	docker run \
		--rm -it \
		--volume="${PWD}:${JEKYLL_PATH}" \
		-p 4000:4000 \
		-p 35729:35729 \
		jekyll/jekyll:${JEKYLL_VERSION} \
		jekyll serve --force_polling --livereload
