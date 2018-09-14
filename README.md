
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- devtools::rmarkdown::render("README.Rmd") -->
<!-- Rscript -e "library(knitr); knit('README.Rmd')" -->
Locally query GenBank <img src="logo.png" height="200" align="right"/>
======================================================================

[![Build Status](https://travis-ci.org/AntonelliLab/restez.svg?branch=master)](https://travis-ci.org/AntonelliLab/restez) [![Coverage Status](https://coveralls.io/repos/github/AntonelliLab/restez/badge.svg?branch=master)](https://coveralls.io/github/AntonelliLab/restez?branch=master) [![DOI](https://zenodo.org/badge/129107980.svg)](https://zenodo.org/badge/latestdoi/129107980)

Download parts of [NCBI's GenBank](https://www.ncbi.nlm.nih.gov/nuccore) to a local folder and create a simple SQL-like database. Use 'get' tools to query the database by accession IDs. [rentrez](https://github.com/ropensci/rentrez) wrappers are available, so that if sequences are not available locally they can be searched for online through [Entrez](https://www.ncbi.nlm.nih.gov/books/NBK25500/). Visit the [website](https://antonellilab.github.io/restez/index.html) to find out more.

Introduction
------------

*Vous entrez, vous rentrez et, maintenant, vous .... restez!*

Downloading sequences and sequence information from GenBank and related NCBI taxonomic databases is often performed via the NCBI API, Entrez. Entrez, however, has a limit on the number of requests and downloading large amounts of sequence data in this way can be inefficient. For programmatic situations where multiple Entrez calls are made, downloading may take days, weeks or even months.

This package aims to make sequence retrieval more efficient by allowing a user to download large sections of the GenBank database to their local machine and query this local database either through package specific functions or Entrez wrappers. This process is more efficient as GenBank downloads are made via NCBI's FTP using compressed sequence files. With a good internet connection and a middle-of-the-road computer, a database comprising 20 GB of sequence information can be generated in less than 10 minutes.

<img src="https://raw.githubusercontent.com/AntonelliLab/restez/master/paper/outline.png" height="500" align="center"/>

Installation
------------

You can install restez from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("AntonelliLab/restez")
```

Quick Examples
--------------

> For more detailed information on the package's functions and detailed guides on downloading, constructing and querying a database, see the [detailed tutorials](https://antonellilab.github.io/restez/articles/restez.html).

### Setup

``` r
# Warning: running these examples may take a few minutes
library(restez)
#> -------------
#> restez v0.1.0
#> -------------
#> Remember to restez_path_set() and, then, restez_connect()
# choose a location to store GenBank files
restez_path_set(rstz_pth)
```

``` r
# Run the download function
db_download()
# connect, ensure safe disconnect after finishing
restez_connect()
#> Remember to run `restez_disconnect()`
# after download, create the local database
db_create()
```

### Query

``` r
# get a random accession ID from the database
id <- sample(list_db_ids(), 1)
#> Warning in list_db_ids(): Number of ids returned was limited to [100].
#> Set `n=NULL` to return all ids.
# you can extract:
# sequences
seq <- gb_sequence_get(id)[[1]]
str(seq)
# definitions
def <- gb_definition_get(id)[[1]]
print(def)
# organisms
org <- gb_organism_get(id)[[1]]
print(org)
# or whole records
rec <- gb_record_get(id)[[1]]
cat(rec)
```

### Entrez wrappers

``` r
# use the entrez_* wrappers to access GB data
res <- entrez_fetch(db = 'nucleotide', id = id, rettype = 'fasta')
cat(res)
# if the id is not in the local database
# these wrappers will search online via the rentrez package
res <- entrez_fetch(db = 'nucleotide', id = c('S71333.1', id),
                    rettype = 'fasta')
#> [1] id(s) are unavailable locally, searching online.
cat(res)
restez_disconnect()
```

Contributing
------------

Want to contribute? Check the [contributing page](https://antonellilab.github.io/restez/CONTRIBUTING.html).

Version
-------

Pre-release version 0 for review.

Licence
-------

MIT

References
----------

Benson, D. A., Karsch-Mizrachi, I., Clark, K., Lipman, D. J., Ostell, J., & Sayers, E. W. (2012). GenBank. *Nucleic Acids Research*, 40(Database issue), D48–D53. <http://doi.org/10.1093/nar/gkr1202>

Winter DJ. (2017) rentrez: An R package for the NCBI eUtils API. *PeerJ Preprints* 5:e3179v2 <https://doi.org/10.7287/peerj.preprints.3179v2>

Author
------

[Dom Bennett](https://github.com/DomBennett)
