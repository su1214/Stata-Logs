texdoc init stata1.tex, replace

/***
\newpage
\section*{Question 4}
\begin{enumerate}[label=(\alph*)]
\item
***/

texdoc stlog
clear
use "/Users/steven_unique/My Drive/FALL 2021/ECO 394M ECONOMETRICS/Problem Sets/PS1/HTV.DTA"
regr educ motheduc fatheduc
texdoc stlog close

/***
\begin{enumerate}[label=\roman*)]
	\item The slope estimate of \textbf{motheduc} indicates that holding 
		\textbf{fatheduc} constant, when \textbf{motheduc} increases by 1, 
		\textbf{educ} would increase by 0.3041971. Similarly,
		the slope estimate of \textbf{fatheduc} indicates that holding 
		\textbf{motheduc} constant, when \textbf{fatheduc} increases by 1, 
		\textbf{educ} would increase by 0..1902858.
	\item $0.3041971 + 0.1902858 = 0.4944829$. $educ$ is expected to increase by
		0.4944829 years.
	\item Yes. It means that with 0 education of both mother and father, a person
		would have at least 6.964355 years of education.
	\item The R-squared is 0.2493, so the correlation between $y$ and $\hat y$ 
		is $\sqrt{0.2493} = 0.49929951$. This serves as an upper bound on the 
		magnitude of the correlation between \textbf{y} and \textbf{motheduc} 
		beceause if all the correlation comes from motheduc which means all the 
		variation in the model is captured by motheduc only, the correlation 
		between y and motheduc would be the same as the one we get from the 
		model.
***/

texdoc stlog
gen parenteduc = motheduc + fatheduc
regr educ parenteduc
texdoc stlog close

/***
	\item The new R-squared is $0.2459 < 0.2493$. The R-squared has declined 
		because it captures less variation of the y variable, as two covariates 
		have been collapsed. The magnitude of the parenteduc slope estimate, 
		which is .2346699, seems sensible because it lies between the magnitude 
		of matheduc, which is .3041971, and that of fatheduc, which is .1902858. 
		An implicit restriction this model is facing is that, by only using the 
		sum, it assumes that mother's and father's length of education have 
		an equal effect on a child's years of education when Model 1 shows that 
		\textbf{motheduc} has more effect than \textbf{fatheduc}.
\end{enumerate}

\item
***/

texdoc stlog
gen educinteraction = motheduc*fatheduc
regr educ motheduc fatheduc educinteraction
texdoc stlog close

/***
\begin{enumerate}[label=\roman*)]
\item It might be expected that the partial effect of on variable changes as 
	another variable changes.
\item The partial effect of \textbf{motheduc} grows by 0.013201 when 
	\textbf{fatheduc} grows by 1 and vice versa.
\item It is 0.1408771 + 0.013201*\textbf{fatheduc}. It depends on the value of 
	fatheduc.
\item 0.1408771 + 0.013201*\textbf{fatheduc} + 0.0285246 + 
	0.013201*\textbf{motheduc} = 0.1694017 + 0.013201(\textbf{fatheduc} + 
	\textbf{motheduc})
\item The R-squared is $0.2530 > 0.2459$. It was expected because we added an 
	additional variable.
\end{enumerate}

\item
***/

texdoc stlog
regr educ motheduc fatheduc abil
texdoc stlog close

/***
\begin{enumerate}[label=\roman*)]
\item When \textbf{abil} increases by one, holding other variables constant, 
	\textbf{educ} is expected to increase by .5024829.
\item The slope estimates of \textbf{motheduc} and \textbf{fatheduc} have 
	declined from Model 1. This is expected because it is likely that longer 
	education is correlated with higher \textbf{abil} and it is now included in 
	the model to capture its effect.
\item
***/

texdoc stlog
sum abil
gen abilstd = abil/2.184406
regr educ motheduc fatheduc abilstd
texdoc stlog close

/***
The slope estimate of abilstd is larger than that of abil, because the 
regression is done on smaller values now. It is easier to interpret the slope 
estimate of abilstd than that of abil because we can see the relation between 
a standard deviation change of ability instead of the raw numbers of ability. 
None of the other estimates, including R-squared, change.
\item
***/

texdoc stlog
replace abilstd = abilstd - 1.796596
regr educ motheduc fatheduc abilstd
texdoc stlog close

/***
The only change happens here is the intercept. It is because \textbf{abilstd} 
is now centered at an average ability, instead of an ability of zero.
\item
***/

texdoc stlog
regr abilstd motheduc fatheduc
predict uhat, residuals
regr educ uhat
texdoc stlog close

/***
It can be verified that the coefficient of the abilstd in this regression is 
the same as in the previous model. This shows that the partitioned regression 
approach works.
\item
To account for different effects of \textbf{abilstd} depending on 
\textbf{motheduc}, I would introduce an interaction variable of 
\textbf{motheduc} and \textbf{abilstd}. If the 
hypothesis was correct, I would expect the coefficeint of 
\textbf{motheduc}*\textbf{abilstd} would be positive.
***/

texdoc stlog
gen mothabil = motheduc*abilstd
regr educ motheduc fatheduc abilstd mothabil
texdoc stlog close

/***
In the new regression, the estimated partial effect of ability is 
$-0.110157 + 0.104223*\textbf{motheduc}$. The estimated partial effect of 
changing \textbf{motheduc} by a year is $0.2978231 + 0.104223*\textbf{abilstd}$.
\end{enumerate}

\item
***/

texdoc stlog
gen abilstd_squared = abilstd^2
regr educ motheduc fatheduc abilstd abilstd_squared
texdoc stlog close

/***
\begin{enumerate}[label=\roman*)]
\item The relationship between a covariate and the dependent variable might be 
	expected to have a non-linear but possibly quadratic relationship.
\item $1.744496 + 2*0.2414397\mathbf{ablistd}$.
\item The estimated partial effect of \textbf{abilstd} in Model 3 is 1.097627, 
	no matter the value of \textbf{abilstd} is. On the other hand, the 
	estimated partial effect of \textbf{abilstd} in Model 4 depends on the 
	value of \textbf{abilstd}. It increases by 0.4828794 when \textbf{abilstd} 
	increases by 1.
\end{enumerate}

\item

\begin{enumerate}[label=\roman*)]
\item 
***/

texdoc stlog
regr west18 ne18 nc18 south18
texdoc stlog close

/***
Yes, I get the expected results. It is because every observation belongs to one 
of the regions. Because of this perfect colinearity, we get R-squared of 1.
\item 
***/

texdoc stlog
regr educ west18
texdoc stlog close

/***
Compared to all the other regions, years of education was lower by 0.2137576 on 
average if the child was in the west when 18.
\item
***/

texdoc stlog
regr educ west18 ne18 nc18
texdoc stlog close

/***
Compared to the south, years of education was higher by 0.2729996 on 
average if the child was in the west when 18.
\item
***/

texdoc stlog
regr educ motheduc fatheduc abilstd abilstd_squared west18 ne18 nc18
texdoc stlog close

/***
Holding \textbf{motheduc}, \textbf{fatheduc} and \textbf{abilstd} constant, 
years of education was lower by 0.1507768 on average if the child was in the 
west when 18 compared to the south.
\item If the region did not matter, the slopes of \textbf{west18}, 
\textbf{ne18}, \textbf{nc18} would be all 0.
\item 
***/

texdoc stlog
regr educ motheduc fatheduc abilstd abilstd_squared south18 ne18 nc18
texdoc stlog close

/***
Now, the west is captured in the intercept. Therefore, the slopes of 
\textbf{motheduc}, \textbf{fatheduc} and \textbf{abilstd} would stay the same 
while the coefficients of the indicator variables would change, now showing the 
difference between the corresponding region and the west. The results show that 
the slopes for \textbf{motheduc}, \textbf{fatheduc} and \textbf{abilstd} stay 
the same.
\end{enumerate}
\end{enumerate}
\newpage
\section*{Question 5}
***/

texdoc stlog
clear
use "/Users/steven_unique/My Drive/FALL 2021/ECO 394M ECONOMETRICS/Problem Sets/PS1/FERTIL2.DTA"
gen heducmissing = (heduc==.)
replace heduc = 0 if heducmissing
texdoc stlog close

/***
\begin{enumerate}[label=(\alph*)]
\item 
***/

texdoc stlog
gen age2 = age^2
regr children age age2 educ evermarr heduc heducmissing
texdoc stlog close

/***
\begin{enumerate}[label=\roman*)]
\item $.2786184 + -2*0.0020174\textbf{age}$
\item $0.1754812$
\end{enumerate}

\item
***/

texdoc stlog
regr children age age2 educ heduc heducmissing if evermarr == 1
regr children age age2 educ heduc heducmissing if evermarr == 0
texdoc stlog close

/***
The effects of age and education are different in the two regressions. They 
look larger in the first regression where \textbf{evermarr} is 1. Stata drops 
\textbf{heduc} and \textbf{heducmissing} because when \textbf{evermarr} is 0, 
\textbf{heduc} is 0 and \textbf{heducmissing} is 1, which means these three are 
perfectly correlated in which case the inverse of $X'X$ cannot be calculated 
and therefore an unique OLS estimator cannot be calculated.
\item
***/

texdoc stlog
regr children age age2 educ electric
texdoc stlog close

/***
The estimated partial effect of \textbf{electric} is -0.3777901. Since it is 
not reasonable to assume that having electricity would negatively affect the 
number of children a woman would have, we should not think of the estimated 
partial effect as the true causal effect but rather think that there would be a 
cofounder.
\item
***/

texdoc stlog
gen ageelectric = age*electric
gen age2electric = age2*electric
gen educelectric = educ*electric
regr children age age2 educ electric ageelectric age2electric educelectric
texdoc stlog close

/***
The estimated partial effect of electric is $-0.599813 + 0.0754904*\textbf{age} 
-0.0020197*\textbf{age}^2 + -0.0212059\textbf{educ}$.
***/

texdoc stlog
gen pe_electric = _b[electric] + _b[ageelectric]*age + _b[age2electric]*age2 + _b[educelectric]*educ
hist pe_electric
texdoc stlog close
texdoc graph, optargs(width=0.5\textwidth)

/***
\item
***/

texdoc stlog
regr children age age2 educ if electric == 0
regr children age age2 educ if electric == 1
texdoc stlog close

/***
The coefficient estimates for \textbf{age}, \textbf{age2}, and \textbf{educ} 
in the regression for the electric = 0 are the same as in the model with 
interactions in part (d).
\end{enumerate}
***/
