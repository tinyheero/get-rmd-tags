# Tag Generation from Rmarkdown Files

The `get-rmd-tags.py` script extracts tags from a Rmarkdown (`.Rmd`) file that
can be used by the tagbar Vim plugin.

The script is a modification of
[rmdtags.py](https://gist.github.com/MaximeWack/cdbdcd373d68d1fe5b3aca22e3dcfe46)
that was created by Maxime Wack. The following modifications were done:

* Added support for chunk labels specified using `#| label:`
* Headers now require a space between the title and the preceeding `#`.

Here is an example of the output:

```bash
$> ./get-rmd-tags.py  tests/test.Rmd
Title   tests/test.Rmd  /^# Title$/;"   h       line:5
test    tests/test.Rmd  /^```{r test}$/;"       c       line:7  header:Title
labelled-chunk  tests/test.Rmd  /^#| label: labelled-chunk$/;"  c       line:11 header:Title
```

To integrate this with tagbar, put this in your `.vimrc` file:

```vim
let g:tagbar_type_rmd = {
          \   'ctagstype':'rmd'
          \ , 'kinds':['h:header', 'c:chunk', 'f:function', 'v:variable']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header', 'c':'chunk'}
          \ , 'sort':0
          \ , 'ctagsbin': '/path/to/get-rmd-tags.py'
          \ , 'ctagsargs': ''
          \ }
```
