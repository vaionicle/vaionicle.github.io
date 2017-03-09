
run:
	bundle exec jekyll serve


deps:
	bundle

setup: install.gem
	bundle install

install.gem:
	sudo gem install jekyll bundler
