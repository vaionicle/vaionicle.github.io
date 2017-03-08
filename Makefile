
run:
	bundle exec jekyll serve


deps:
	bundle

setup: install.gem

install.gem:
	gem install jekyll bundler
