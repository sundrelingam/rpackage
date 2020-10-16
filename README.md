# `rpackage`
## Dummy package to demo how Depends, Imports, and @import differs

There are a lot of great resources on how to properly handle `R` package metadata and namespaces, but this simple package serves as a concrete example that can be cloned and experimented with.

First install this package:
```r
#install.packages("devtools")
devtools::install_github("sundrelingam/rpackage")
library(rpackage)
```

Now this package is attached to the search path, along with it's dependent package `dplyr`. So you can use `dplyr` functions without having to attach `dplyr` with `library` or `::`:
```r
mtcars %>% select(disp)
```

But because `dplyr` is now attached to *your* search path, my function can call `dplyr` functions even though it's not in the package's namespace, because `R` will eventually find the functions in *your* search path through lexical scoping:
```r
# how the function is using `dplyr` without attaching it
installed_and_dependent

# run it, it works
installed_and_dependent()

# more details about what is being done here
?installed_and_dependent
```

The safer way to do the above, without affecting the *user's* search path, is to use `@import` and add the function to my package's namespace:
```r
installed_and_imported
installed_and_imported()
```

But note how I haven't affected the user's search path:
```r
drop_na(mtcars) #error
```

*Note that all the functions in this package require the packages they use to be installed.*

I only need to add the function to the package namespace if I want to use it without specifying the search path. For example, even without `@import`, I can use a function from `tibble` by specifying the search path with `::`:
```r
installed_and_attached
installed_and_attached()
```

But if I didn't add it to the package namespace, I wouldn't be able to call it without specifying the search path:
```r
installed_not_attached
installed_not_attached()
```
