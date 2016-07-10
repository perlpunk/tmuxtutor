manpages:
	for i in 01.basics 02.prefix 03.windows 04.panes 05.layouts; do \
		echo $$i; \
		swim --to man "txt/$$i.txt" > "man/$$i.man"; \
	done

htmlpages:
	for i in 01.basics 02.prefix 03.windows 04.panes 05.layouts; do \
		echo $$i; \
		swim --to html "txt/$$i.txt" > "html/$$i.html"; \
	done
ghpages: htmlpages
	perl bin/generate-pages.pl && \
	git co gh-pages && \
	cp out-html/*.html tutor/ && \
	git add tutor && \
	git commit  --amend --no-edit && \
	git checkout master

