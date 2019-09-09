JEKYLL_VERSION=4.0
JEKYLL_PATH=/srv/jekyll

sync.wiki:
	

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
		jekyll/jekyll:${JEKYLL_VERSION} \
		jekyll serve --force_polling --livereload
