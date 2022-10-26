# Retrieve all the possible HTML files that could be generated
RMARKDOWN_FILES = $(wildcard *.Rmd)
MD_FILES = $(RMARKDOWN_FILES:.Rmd=.md)

get_reports : $(MD_FILES)

# Generic Recipe to Render Single HTML File
%.md : %.Rmd
	Rscript --slave -e "rmarkdown::render('$<')"
