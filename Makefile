F=markdown-rmarkdown-reference

assets/$(F).pdf: about.md index.md rmarkdown.md
	echo '---' > $(F).md
	echo 'title: Markdown + RMarkdown Reference' >> $(F).md
	echo 'author: Stephen D. Turner, Ph.D.' >> $(F).md
	echo '---' >> $(F).md
	echo >> $(F).md
	$(foreach f,$^,cat $(f) >> $(F).md; echo>>$(F).md; echo>>$(F).md; echo '\\newpage' >> $(F).md; echo>>$(F).md;)
	gsed -i 's/### \*\*Header 2\*\*/## Header 2/g' $(F).md
	pandoc -s -V geometry:margin=1in -V documentclass:article -V fontsize=10pt $(F).md -o $@
	rm $(F).md

clean: 
	rm -f assets/$(F).pdf $(F).md