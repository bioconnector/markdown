markdown.pdf: index.md rmarkdown.md about.md
	# pandoc -s -V geometry:margin=1in -V documentclass:article -V fontsize=10pt $^ -o $@
	$(foreach f,$^,cat f > tmp; echo newline > tmp)