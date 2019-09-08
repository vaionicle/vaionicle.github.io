JEKYLL_VERSION=3.8
JEKYLL_PATH=/srv/jekyll

run:
	bundle exec jekyll serve

deps:
	bundle

setup: install.gem
	bundle install

install.gem:
	sudo gem install jekyll bundler



build:
	docker run --rm -it --volume="${PWD}:${JEKYLL_PATH}" jekyll/jekyll:${JEKYLL_VERSION} jekyll build

serve:
	docker run --rm -it --volume="${PWD}:${JEKYLL_PATH}" -p 4000:4000 jekyll/jekyll:${JEKYLL_VERSION} jekyll serve
