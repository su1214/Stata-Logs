texdoc init ps3_stata2.tex, replace

/***
\newpage
\section*{Question 6}
\begin{enumerate}[label=(\alph*)]
\item
***/
texdoc stlog
use "voucher.dta", clear
count if select == 0
count if selectyrs == 4
count if choiceyrs == 4
texdoc stlog close
/***
468 students were never awarded a voucher. 108 had a voucher available for four 
years. 56 attended a choice school for four years.
\item
***/
texdoc stlog
regr choiceyrs selectyrs, r
texdoc stlog close
/***
They are highly positively related, as expected. The p-value is 0.000 and the 
relationship is very strong. \emph{selectyrs} is a sensible IV candidate for 
\emph{choiceyrs} as it is highly correlated with \emph{selectyrs} and not 
correlated with $u_1$ because it was randomly selected.
\item
***/
texdoc stlog
regr mnce choiceyrs, r
regr mnce choiceyrs black hispanic female, r
texdoc stlog close
/***
The slope estimator of \emph{choiceyrs} is  -1.837014. It does not makes sense 
as the more a student attends a choice school, the less they do well on the 
math exam. It becomes -.5652475 when I add \emph{black}, \emph{hispanic}, and 
\emph{female}, making it less negatively related.
\item \emph{choiceyrs} might be endogenous in this equation because student 
have to apply for the voucher in order to be considered awarded, which is not 
a random process even though the vouchers were chosen by lottery among those 
who applied.
\item
***/
texdoc stlog
ivregress 2sls mnce (choiceyrs = selectyrs) black hispanic female, r
texdoc stlog close
/***
Using IV does not produce a positive effect of attending a choice school as the 
coefficient of \emph{choiceyrs} is -.2413189, which is still negative. However, 
the coefficient did increase from -.5652475. As the other explanatory variables 
are not correlated with the instrument variable \emph{selectyrs} and therefore 
their coefficients do not differ from the OLS ones.
\item
***/
texdoc stlog
regr mnce choiceyrs black hispanic female mnce90, r
ivregress 2sls mnce (choiceyrs = selectyrs) black hispanic female mnce90, r
texdoc stlog close
/***
$\beta_1$ in OLS is .4105823 and $\beta_1$ in IV is 1.799385. For the IV 
estimate, each year in a choice school is worth 1.80 on the math percentile 
score. Not even 2 percentile change can't be seen as a practically large effect.
\item Compared to part (d) where there are 990 observations, there are only 
328 observations for the analysis from part (f). This makes the analysis from 
part (f) not entirely convincing.
\item
***/
texdoc stlog
ivregress 2sls mnce (choiceyrs1 choiceyrs2 choiceyrs3 choiceyrs4 = /*
*/ selectyrs1 selectyrs2 selectyrs3 selectyrs4) black hispanic female, r
texdoc stlog close
/***
\item
***/
texdoc stlog
ivregress 2sls mnce (choiceyrs = /*
*/ selectyrs1 selectyrs2 selectyrs3 selectyrs4) black hispanic female, r
texdoc stlog close
/***
Here, $\beta_1$ estimate is -.252745 whereas it was -.2413189 in part (e). They 
are very similar to each other.
***/
texdoc stlog
ivregress gmm mnce (choiceyrs = /*
*/ selectyrs1 selectyrs2 selectyrs3 selectyrs4) black hispanic female, r
estat overid
texdoc stlog close
/***
The p-value for the overidentification test is 0.6345.
\item We could include \emph{selectyrs} as a covariate. This would enable us to 
see the effect of each of other covariates holding \emph{selectyrs} constant.
\end{enumerate}
***/
