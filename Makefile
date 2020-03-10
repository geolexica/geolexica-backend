SHELL := /bin/bash

all: _site

clean:
	rm -rf _site _concepts

distclean: clean
	rm -rf _data/info.yaml

data: _data/info.yaml _data/metadata.yaml _concepts

_site: data | bundle
	bundle exec jekyll build

bundle:
	bundle

_data/info.yaml:
	cp -f geolexica-database/tc211-termbase.meta.yaml $@

_data/metadata.yaml:
	cp -f geolexica-database/metadata.yaml $@

# Make collection YAML files into adoc files
_concepts:
	cp -a geolexica-database/concepts _concepts; \
	pushd $@; \
	for filename in *.yaml; do \
		[ -e "$$filename" ] || continue; \
			NEW_NAME=$${filename//yaml/adoc}; \
			NEW_NAME=$${NEW_NAME//concept-/}; \
		mv $$filename $${NEW_NAME}; \
			echo "---" >> $${NEW_NAME}; \
	done; \
	popd

serve:
	bundle exec jekyll serve

update-init:
	git submodule update --init

update-modules:
	git submodule foreach git pull origin master

.PHONY: data bundle all open serve distclean clean update-init update-modules
