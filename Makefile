manpages:
	perl bin/generate-pages.pl manpages

htmlpages:
	perl bin/generate-pages.pl htmlpages

ghpages: htmlpages
	perl bin/generate-pages.pl ghpages && \
	git checkout gh-pages && \
	cp out-html/*.html tutor/ && \
	git add tutor && \
	git commit  --amend --no-edit && \
	git checkout master

publish:
	git push --force origin gh-pages
