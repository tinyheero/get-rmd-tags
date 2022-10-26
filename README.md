<!-- README.md is generated from README.Rmd. Please edit that file -->

# 1 Tag Generation from Rmarkdown Files

The `get-rmd-tags.py` script extracts tags from a Rmarkdown (`.Rmd`)
file that can be used by the tagbar Vim plugin. The script is a
modification of
[rmdtags.py](https://gist.github.com/MaximeWack/cdbdcd373d68d1fe5b3aca22e3dcfe46)
that was created by Maxime Wack. The following modifications were done:

-   Added support for chunk labels specified using `#| label:`
-   Headers now require a space between the title and the preceeding
    `#`.

# 2 Tutorial

Given an example Rmarkdown file (`tests/test.Rmd`):

    ---
    title: "Test Rmarkdown Files"
    ---

    # Title

    ```{r test}
    ```

    ```{r}
    #| label: labelled-chunk
    ```

If we ran `get-rmd-tags.py` on this file, we would get

``` bash
./get-rmd-tags.py tests/test.Rmd
```

    Title   tests/test.Rmd  /^# Title$/;"   h   line:5  
    test    tests/test.Rmd  /^```{r test}$/;"   c   line:7  header:Title
    labelled-chunk  tests/test.Rmd  /^#| label: labelled-chunk$/;"  c   line:11 header:Title

## 2.1 Integrating this with Tagbar

To integrate this with tagbar, `git clone` this repository. Then put
this in your `.vimrc` file:

    let g:tagbar_type_rmd = {
              \   'ctagstype':'rmd'
              \ , 'kinds':['h:header', 'c:chunk', 'f:function', 'v:variable']
              \ , 'sro':'&&&'
              \ , 'kind2scope':{'h':'header', 'c':'chunk'}
              \ , 'sort':0
              \ , 'ctagsbin': '/path/to/get-rmd-tags.py'
              \ , 'ctagsargs': ''
              \ }

and change the value of the `ctagsbin` key to point to the
`get-rmd-tags.py` script in this repository.
