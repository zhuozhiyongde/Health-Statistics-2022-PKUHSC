\name{NEWS}
\title{PMCMRplus News}
\encoding{UTF-8}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.6 (2022-08-17)}{
 \subsection{NEW FEATURES}{
  \itemize{
   \item Function \code{chenJanTest} was added. Step-down p-adjustment
   according to Chen (1999) was added for functions \code{chenTest} and
   \code{chenJanTest}.
  }
 }
 \subsection{BUG FIXES}{
  \itemize{
   \item Function \code{frdHouseTest} was fixed in such a way
   that y, groups and blocks can be passed as vectors.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.5 (2022-07-10)}{
 \subsection{NEW FEATURES}{
  \itemize{
   \item Functions \code{chenTest}, \code{Dunnett},
   \code{frdHouseTest}, \code{power.dunnett.test},
   \code{power.tukey.test} and \code{power.williams.test}
   were added.
  }
 }
 \subsection{OTHER CHANGES}{
  \itemize{
   \item Code in \code{init.c} was re-written based on
   \code{tools::package_native_routine_registration_skeleton}.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.4 (2022-04-07)}{
 \subsection{BUG FIX}{
  \itemize{
   \item Function \code{dscfAllPairsTest} always returned \code{NA}.
   This has been fixed.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.3 (2021-11-13)}{
 \subsection{BUG FIX}{
  \itemize{
   \item Function \code{manyOneUTest} always returned \code{NA}.
   This has been fixed.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.2 (2021-10-12)}{
 \subsection{OTHER CHANGES}{
  \itemize{
   \item An order restriction for factor levels
   was implemented in the function \code{jonckheereTest},
   which allows an un-sorted input.
   \item The Rd-files were updated for all trend-test procedures with a note on how to label the factor levels
   from zero-dose control to highest dose level.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.1 (2021-09-21)}{
 \subsection{BUGFIX}{
  \itemize{
   \item The function \code{manyOneUTest} was corrected
   in order to become workable.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.9.0 (2021-01-12)}{
 \subsection{NEW FEATURES}{
  \itemize{
   \item The function{mrrTest} to conduct
   Madhava Rao-Raghunath exact symmetry test was added.
   \item The functions \code{hayterStoneTest},
   \code{hsAllPairsTest} and \code{NPMTest} were extended for
   calculating asymptotic p-values with the code
   of \code{pHayStonLSA} of the package \pkg{NSM3}.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.8.0 (2020-12-06)}{
 \subsection{NEW FEATURES}{
  \itemize{
   \item The Shan-Young-Kang test for testing against
   ordered alternatives
   was implemented in function \code{shanTest}.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.7.1 (2020-11-29)}{
 \subsection{BUGFIX}{
  \itemize{
   \item The function \code{uryWigginsHochbergTest} was
   corrected in order to return the two-tailed p-value.
  }
 }
 \subsection{OTHER CHANGES}{
   \itemize{
     \item In the demo \code{algae} the step-down
     trend examples were replaced with
     the corresponding novel function
     \code{stepDownTrendTest}.
     \item The method for class \code{"aov"} was implemented
    for the function \code{williamsTest}.
     \item The function \code{toTidy} was extended for
     functions of two-way rank ANOVA.
     \item Several \code{Rd} files were updated and extended.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.7.0 (2020-10-29)}{
 \subsection{NEW FEATURES}{
  \itemize{
    \item The functions \code{hayterStoneTest}
    and \code{hsAllPairsTest} were implemented.
    \item The function \code{toTidy} was implemented
    based on a valuable recommendation of Indrajeet Patil.
    \item The method for class \code{"aov"} was implemented
    for the functions \code{osrtTest} and \code{MTest}.
    \item The function \code{stepDownTrendTest} as well as
    corresponding \code{print} and \code{summary} methods were
    implemented to perform step-down tren test procedures.
    \item the functions \code{hayterStoneTest}, \code{hsAllPairsTest}
    and \code{NPMTest} were extended for \code{method = "boot"},
    with which an asymetric permutation test is conducted
    and \eqn{p}-values are returned.
  }
 }
 \subsection{OTHER CHANGES}{
   \itemize{
     \item The function \code{chaAllPairsNashimotoTest} was
     enhanced for NPT'-test, where p-values are calculated from the
     standard normal distribution and NPY'-test, where the statistic(s)
     are compared with ciritical h-values.
     \item The function \code{chackoTest} was extended for
     \code{alternative = c("greater","less")}.
     \item The Rd-files of several functions were revised.
   }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.6.1 (2020-10-21)}{
 \subsection{NEW FEATURES}{
  \itemize{
    \item The \code{flignerWolfeTest} and
    \code{chackoTest} were implemented
    in the function \code{powerOneWayTest}.
    }
  }
 \subsection{BUGFIX}{
   \itemize{
     \item The functions \code{MTest} and \code{osrtTest} were
     corrected in such a way, that estimated statistics are
     compared with critical h-values from an internal look-up
     table.
     \item The function \code{chaAllPairsNashimotoTest} was corrected
     for the NPM-test. p-values are now calculated from the
     standard normal distribution.
   }
 }
 \subsection{OTHER CHANGES}{
   \itemize{
     \item A new generic method \code{print.osrt} and
     \code{summary.osrt} was coded for all functions that use
     critical values for decisions, i.e. \code{osrtTest},
     \code{MTest}, \code{steelTest}, \code{williamsTest} and
     \code{shirleyWilliamsTest}. Other \code{print} and
     \code{summary} methods were removed.
   }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.6.0 (2020-10-13)}{
 \subsection{NEW FEATURES}{
  \itemize{
    \item The Fligner-Wolfe test was implemented in function \code{flignerWolfeTest}.
    }
  }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.5.1 (2020-09-26)}{
 \subsection{BUGFIX}{
  \itemize{
    \item \code{kwManyOneNdwTest} was corrected for directed hypothesis testing.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.5.0 (2020-09-09)}{
 \subsection{NEW FEATURES}{
  \itemize{
    \item S3 method for class\sQuote{aov} was added
    for \code{tukeyTest}, \code{gamesHowellTest},
    \code{lsdTest}, \code{tamhaneT2Test},
    \code{uryWigginsHochbergTest}, \code{dunnettT3Test},
    \code{snkTest}, \code{scheffeTest}, \code{dunnettTest},
    \code{tamhaneDunnettTest} and \code{welchManyOneTTest}.
    \item Updated concept-tag in Rd files.
  }
 }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.4.4}{
  \subsection{OTHER CHANGES}{
    \itemize{
      \item The examples in \code{kruskalTest}, \code{adKSampleTest}
      and \code{bwsKSampleTest} were
      changed for compatibility with
      the upcoming \sQuote{stringsAsFactors = FALSE} default in R (4.0.0).
      }
    }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.4.3}{
  \subsection{OTHER CHANGES}{
    \itemize{
     \item The names for the \sQuote{method} were corrected for \code{adAllPairsTest} and \code{bwsAllPairsTest}.
     \item The example in \code{adKSampleTest} was corrected.
     }
   }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.4.2}{
 \subsection{NEW FEATURES}{
    \itemize{
      \item The S3 method for class \sQuote{formula} was added
      for \code{frdAllPairsNemenyiTest}.
      }
}
 \subsection{OTHER CHANGES}{
    \itemize{
      \item The novel internal function \code{frdRanks} was added
      for consistent Friedman-type ranking.
    }
  }
  \subsection{BUGFIXES}{
     \itemize{
       \item Results of all \code{frd[.]Test} and \code{quadeAllPairsTest} depended on the sequential
       order of groups and blocks. This has been fixed.
       Thanks to Jakob Richter, email 2019-10-15.
       \item The function \code{frdManyOneExactTest} was
       corrected towards \sQuote{alternative == "two.sided"} only.
     }

   }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.4.1}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item The function \code{hartleyTest} for performing
      Hartley's Maximum F-Ratio Test of Homogeneity of Variances
      was added.
      }
  }
  \subsection{OTHER CHANGES}{
    \itemize{
      \item The demo trout.R was updated.
    }
  }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.4.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item The function \code{siegelTukeyTest} for
      performing the Siegel-Tukey rank dispersion test
      was added.
      \item The function \code{GSTTest} for
      performing the Generalized Siegel-Tukey Test
      for rank dispersion was added.
    }
  }
  \subsection{BUGFIXES}{
   \itemize{
     \item The names of columns and rows of the lower
     triangle matrix in any of the functions
     \code{frdAllPairs*}, \code{frdManyOne*} and
     \code{quadeAllPairsTest} were occasionally wrong.
     The bug only appeared, if \code{y, group, block}
     were provided as vectors and the group vector was
     sorted. This bug has been fixed.
   }
  }
    \subsection{OTHER CHANGES}{
    \itemize{
      \item Example of Rd file of \code{kruskalTest}
      was modified to show equality of Conover's F and
      one-way ANOVA F-Test with ranks.
    }
  }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.3.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item The function \code{snkTest} for performing
      the Student-Newman-Keuls test was added.
      \item The funtion \code{duncanTest} for performing
      the Duncan's (new) multiple range test was added.
      \item The funtion \code{welchManyOneTTest} for performing
      many-to-one comparisons with Welch's t-test was added.
      Likewise, \code{welchManyOneTTest} was added as \code{test}
      in function \code{powerMCtests}
      \item The funtion \code{steelTest} including
      print and summary S3-methods for applying
      Steel's Many-to-One Rank Test was added.
      \item The function \code{tamhaneT2Test} was extended
      for performing Tamhane's extended T2' test as well. Thanks to
      Sirio Bolaños.
    }
  }
  \subsection{BUGFIXES}{
    \itemize{
      \item Several Rd files were corrected (e.g. links to other man
      files, corrected calls to functions in examples section)
      \item The function \code{tamhaneT2Test} was corrected in order
      to compute the two-tailed p-value with Sidaks p-adjustment using
      \eqn{m = k(k-1)/2}.
    }
  }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.2.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item The function \code{shirleyWilliamsTest} was extended
      for alternatives less and greater using a look-up table
      for critical Williams-t values including
      print and summary methods.
    }
  }
  \subsection{BUGFIXES}{
    \itemize{
      \item Links in Rd file of bwsManyOneTest were corrected.
    }
  }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.1.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item The function \code{williamsTest}
      including print and summary methods were added.
    }
  }
}
\section{CHANGES IN PMCMRPLUS VERSION 1.0.1}{
  \subsection{BUGFIXES}{
    \itemize{
      \item Misspelled author name Terpstra was
      corrected in function \code{jonckheereTest}
      and corresponding Rd file.
      \item Reference in the title of Rd files
      for functions \code{mandelhTest} and \code{mandelkTest}
      were corrected.
    }
  }
}
