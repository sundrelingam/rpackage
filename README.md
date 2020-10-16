# `rpackage`
## Dummy package to demo how Depends, Imports, and @import differ

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
# > installed_and_dependent
# function() {
#   mtcars  %>% select(disp)
# }

installed_and_dependent()

# more details about what is being done here
?installed_and_dependent
```

The safer way to do the above, without affecting the *user's* search path, is to use `@import` and add the function to my package's namespace:
```r
# > installed_and_imported
# function() {
#   drop_na(mtcars)
# }

installed_and_imported()
```

But note how I haven't affected the user's search path:
```r
drop_na(mtcars) #error
```

*Note that all the functions in this package require the packages they use to be installed.*

I only need to add the function to the package namespace if I want to use it without specifying the search path. For example, even without `@import`, I can use a function from `tibble` by specifying the search path with `::`:
```r
# > installed_and_attached
# function() {
#   tibble::as_tibble(mtcars)
# }

installed_and_attached()
```

But if I didn't add it to the package namespace, I wouldn't be able to call it without specifying the search path:
```r
# > installed_not_attached
# function() {
#   as_tibble(mtcars)
# }

installed_not_attached() #error
```

### Collate

I've also included this subsection for `Collate`. This isn't needed **at all** except for defining `S4` generics and methods. We can see from the `Collate` order that `s3_a.R` containing the methods for the `s3` generic is sourced *after* the file containing the generic (`s3_b.R`), but it causes no issues:
```r
# > s3("")
# [1] "S3 Character method dispatched."
```

For `S4` however, if we attempted to build the package by sourcing the files using the default alphabetical order without `Collate`, the build would fail. This can be demonstrated by removing the `@include s4_b.R` tag in `s4_a.R` (which specifies the `Collate` order) and attempting to build the package.
