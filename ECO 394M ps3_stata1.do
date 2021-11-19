texdoc init ps3_stata1.tex, replace

/***
\newpage
\section*{Question 5}
\begin{enumerate}[label=(\alph*)]
\item
***/
texdoc stlog
use "children_sample.dta", clear
keep if white & male
tabstat bmi, statistics(p10 p25 p50 mean p75 p90)
texdoc stlog close
/***
\item
***/
texdoc stlog
hist bmi
texdoc stlog close
texdoc graph, optargs(width=0.5\textwidth)
/***
Yes, it makes sense. Mean is higher than median because of the righthand 
values away from the average. Other quantiles also seems right.
\item
***/
texdoc stlog
regr bmi educ age mombmi dadbmi, r
texdoc stlog close
/***
The slope estimates tells us how a unit increase of each covariate would 
affect \textbf{bmi}, holding all others fixed.
\item
***/
texdoc stlog
sqreg bmi educ age mombmi dadbmi, reps(500)
texdoc stlog close
/***
\begin{enumerate}[label=\roman*.]
\item A unit increase of \textbf{educ} would bring the median of \textbf{bmi} 
up by $.053927$, holding all others fixed.
\item 
***/
texdoc stlog
nlcom _b[mombmi] + _b[dadbmi], l(90)
texdoc stlog close
/***
The median of \textbf{bmi} is expected to increase by $.3092614$, holding all 
others fixed. The 90\% confidence interval for this effect is given in the 
Stata result.
\item
***/
texdoc stlog
sqreg bmi educ age mombmi dadbmi, reps(500)
texdoc stlog close
/***
The standard errors and z-statistics are slightly different because it is 
from different bootstrap samples than before.
\end{enumerate}
\item
***/
texdoc stlog
sqreg bmi educ age mombmi dadbmi, q(.1 .25 .5 .75 .90) reps(500)
texdoc stlog close
/***
\begin{enumerate}[label=\roman*.]
\item The slope estimate of \textbf{educ} becomes negative for q90.
\item Yes, it looks the original linear regression had heteroskedastic errors.
It is obvious because if errors were homoskedastic, the slope estimates of any 
covariate in the quantile regression should be consistent over different $\tau$
values.
\item
***/
texdoc stlog
testnl [q10]_b[age]=[q25]_b[age]=[q50]_b[age]=[q75]_b[age]=[q90]_b[age]
texdoc stlog close
/***
It is 0.3848.
\item
***/
texdoc stlog
testnl ([q50]_b[mombmi] = [q90]_b[mombmi]) ([q50]_b[dadbmi] = [q90]_b[dadbmi])
texdoc stlog close
/***
P-value is 0.0043.
\item
***/
texdoc stlog
preserve
collapse (mean) educ age mombmi dadbmi
tempfile means
save `means'
restore
append using `means'
sqreg bmi educ age mombmi dadbmi, q(.1 .25 .5 .75 .90) reps(500)
predict q10bmihat, equation(#1)
predict q90bmihat, equation(#5)
list q10bmihat q90bmihat in -1
texdoc stlog close
/***
(20.73985, 30.82972). Unconditional: (20.2, 30.95)
\end{enumerate}
***/
/***
\end{enumerate}
***/
