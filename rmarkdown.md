# RMarkdown

## What is RMarkdown?

RMarkdown is an enhanced version of Markdown that lets you embed R code into the document. When the document is compiled/rendered, the R code is executed by R, the output is then automatically rendered as Markdown with the rest of the document. 

## RMarkdown code chunks

### RMarkdown code as written

When writing an RMarkdown document, put R code to be executed in a fenced block with `{r}` after the first set of fences. Here's an example of what RMarkdown looks like:

    Here's some plain old Markdown text. We can use _italics_ or **bold** or whatever we want here. But check this out below. We're going to embed an R code chunk.

    ```{r}
    # This is a comment. 
    # This is the start of an R code chunk.
    # Let's generate 10 random numbers between 1 and 100
    set.seed(42)
    x <- sample(1:100, 5)
    x
    ```

    Now we're out of our R code and back into plain Markdown. Why don't we take the mean of `x`?

    ```{r}
    mean(x)
    ```

    Neat eh?


### Result after rendering

Here's some plain old Markdown text. We can use _italics_ or **bold** or whatever we want here. But check this out below. We're going to embed an R code chunk.


```r
# This is a comment. 
# This is the start of an R code chunk.
# Let's generate 10 random numbers between 1 and 100
set.seed(42)
x <- sample(1:100, 5)
x
```

```
## [1] 92 93 29 81 62
```

Now we're out of our R code and back into plain Markdown. Why don't we take the mean of `x`?


```r
mean(x)
```

```
## [1] 71.4
```

Neat eh?

## How does it work?

The workflow looks something like this.

1. You write the RMarkdown document. It's just regular Markdown with R code chunks scattered throughout.
2. When you hit the "Knit" button in RStudio, a package called [knitr](http://yihui.name/knitr/) is envoked in the background to go through your RMarkdown document. Every time it encounters an R code chunk, it actually runs that R code in R. Both the code in the chunk and the result of the evaluation are then woven back into a regular markdown document as valid markdown syntax. You never see this intermediate plain markdown file.
3. A universal text format conversion tool called [Pandoc](http://pandoc.org/) is then called to convert that intermediate Markdown text into some other downstream format (HTML, PDF, DOCX, etc.).

![](assets/rmarkdown-workflow.png)

## Inline RMarkdown

In addition to writing chunks of R code, you can also write R code inline with the rest of your Markdown using the syntax `r <code here>`. For example, if you had this line in your RMarkdown document, outside of a chunk:

```
Two to the eighth power is `r 2^8`. Yay!
```

Then the resulting output would include the number 256 in place of the `r 2^8`.

## Options

Modify the behavior of an R chunk with [options](http://yihui.name/knitr/options/). Options are passed in after a comma on the fence, as shown below. 

    ```{r, echo=TRUE, results='hide'}
    # R code here
    ```

Some commonly used options include:

- `echo`: (`TRUE` by default) whether to include R source code in the output file.
- `results` takes several possible values:
    - `markup` (the default) takes the result of the R evaluation and turns it into markdown that is rendered as usual.
    - `hide` will hide results.
    - `hold` will hold all the output pieces and push them to the end of a chunk. Useful if you're running commands that result in lots of little pieces of output in the same chunk.
    - `asis` writes the raw results from R directly into the document. Only really useful for tables.
- `include`: (`TRUE` by default) if this is set to `FALSE` the R code is still evaluated, but neither the code nor the results are returned in the output document. 
- `fig.width`, `fig.height`: used to control the size of graphics in the output.

See the full list of options here: <http://yihui.name/knitr/options/>. There are lots!

## Printing tables nicely

The [knitr](http://yihui.name/knitr/) package that runs the RMarkdown document in the background also has a function called `kable` that helps with printing tables nicely. It's only useful when you set `echo=FALSE` and `results='asis'`. Check out the difference below.

### Without using `kable`

***Code in the RMarkdown document:***

    ```{r, echo=FALSE}
    head(mtcars)
    ```

***Resulting intermediate Markdown:***

    ```
    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
    ```


***Rendered output:***

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

### Results using `kable`

***Code in the RMarkdown document:***

    ```{r, echo=FALSE, results='asis'}
    library(knitr)
    kable(head(mtcars))
    ```

***Resulting intermediate Markdown:***

    |                  |  mpg| cyl| disp|  hp| drat|    wt|  qsec| vs| am| gear| carb|
    |:-----------------|----:|---:|----:|---:|----:|-----:|-----:|--:|--:|----:|----:|
    |Mazda RX4         | 21.0|   6|  160| 110| 3.90| 2.620| 16.46|  0|  1|    4|    4|
    |Mazda RX4 Wag     | 21.0|   6|  160| 110| 3.90| 2.875| 17.02|  0|  1|    4|    4|
    |Datsun 710        | 22.8|   4|  108|  93| 3.85| 2.320| 18.61|  1|  1|    4|    1|
    |Hornet 4 Drive    | 21.4|   6|  258| 110| 3.08| 3.215| 19.44|  1|  0|    3|    1|
    |Hornet Sportabout | 18.7|   8|  360| 175| 3.15| 3.440| 17.02|  0|  0|    3|    2|
    |Valiant           | 18.1|   6|  225| 105| 2.76| 3.460| 20.22|  1|  0|    3|    1|

***Rendered output:***

|                  |  mpg| cyl| disp|  hp| drat|    wt|  qsec| vs| am| gear| carb|
|:-----------------|----:|---:|----:|---:|----:|-----:|-----:|--:|--:|----:|----:|
|Mazda RX4         | 21.0|   6|  160| 110| 3.90| 2.620| 16.46|  0|  1|    4|    4|
|Mazda RX4 Wag     | 21.0|   6|  160| 110| 3.90| 2.875| 17.02|  0|  1|    4|    4|
|Datsun 710        | 22.8|   4|  108|  93| 3.85| 2.320| 18.61|  1|  1|    4|    1|
|Hornet 4 Drive    | 21.4|   6|  258| 110| 3.08| 3.215| 19.44|  1|  0|    3|    1|
|Hornet Sportabout | 18.7|   8|  360| 175| 3.15| 3.440| 17.02|  0|  0|    3|    2|
|Valiant           | 18.1|   6|  225| 105| 2.76| 3.460| 20.22|  1|  0|    3|    1|

## Learn more

- The knitr website (**<http://yihui.name/knitr/>**) has lots of useful reference material about how knitr works, [options](http://yihui.name/knitr/options/), and more.
- The RMarkdown documentation (**<http://rmarkdown.rstudio.com/>**) has an excellent [getting started guide](http://rmarkdown.rstudio.com/lesson-1.html), a [gallery of demos](http://rmarkdown.rstudio.com/gallery.html), and several [articles](http://rmarkdown.rstudio.com/articles.html) illustrating advanced usage.
- RStudio's [RMarkdown Cheat Sheet](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf) and [RMarkdown Reference Sheet](http://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf).