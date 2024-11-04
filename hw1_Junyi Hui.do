clear all
cap log close
set more off

capture cd "/Users/user/Desktop/Fall_quarter/ECON/ECON120C-FA24/hw1"
capture log using hw1_JunyiHui.log, text replace

*********************************************
*Econ 120C, FA24
*Source Code for HW1
*Name: Junyi Hui
*Email: hjunyi@ucsd.edu
*PID: A69035733
*********************************************

/* Load the dataset and save it under a different name as stated in instructions*/

use loanapp_FA24.dta
save loanapp_FA24_replica.dta,replace

/* Always start by checking what is on the dataset */
describe

/* Question 2. Single OLS Regression */
regress approve white 

scalar q2a = _b[white]+_b[_cons]
display q2a

/* Question 3. Multivariate OLS Regression */
regress approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr


/* Question 4. Predicted Probabilities */
estat summarize
margins,at(loanprc=0.95 white=1 mortlat1=0 mortlat2=0 pubrec=0 male=1 married=1 sch=1 cosign=1 chist=1 vr=1 (mean) hrat obrat unem dep) 
scalar q4 =r(b)[1,1]
display q4

/* Question 5. Check whether fitted values are in the 0-1 range */
predict yhat
count if yhat > 1
scalar q5a =r(N)
display q5a

count if yhat < 0
scalar q5b =r(N)
display q5b


/* Question 6. Single Probit */
probit approve white 

scalar q6 = (_b[white]*1+_b[_cons])-(_b[white]*0+_b[_cons])
display q6

/* Question 8. Multivariate Probit */
probit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr

matrix list r(table)
scalar q8 =r(table)[3,1]
display q8

/* Questions 9. Predicted probabilities for each level of dep, keeping the continuous variables at their means.*/
margins,at(dep=(1 4)) atmeans 

scalar q9 =abs(r(table)[1,1]-r(table)[1,2])
display q9



/* Question 10. Predicted probabilities for each level of dep, keeping the continuous variables at their means.*/
margins,at(dep=(2)) atmeans 

scalar q10 =r(table)[1,1]
display q10


/*Question 11 */
margins, at(dep=(2))

scalar q11 =r(table)[1,1]
display q11


/*Question 12 - Graph */
margins, at(white=(0 1) loanprc=(0(0.2)2.6) )
marginsplot, plot(white) noci



/* Question 14. Logit and Measure of Fit */
logit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
estat classification

scalar q14a =88.05
display q14a
scalar q14b =15.94
display q14b  

/* Questions 15-17. Logit and Pseudo-R2 */

scalar q15 =-616.09
display q15

logit approve
scalar q16 =-751.01
display q16

scalar q17 =1-q15/q16
display q17





scalar list

log close



