## testhta
> custom unit tests for HTA models

using `testthat` custom expectations
https://testthat.r-lib.org/articles/custom-expectation.html

You don't have to understand all the code to know if works so you don't need to be an expert R programmer. Just like in industry, the quality of the code is determined by the testing. I think that all you need is to be sure that it passed a defined set of tests. This ideas has been started [here](https://link.springer.com/article/10.1007/s40273-017-0508-2?shared-article-renderer) [1] and [here](https://link.springer.com/article/10.1007/s40273-014-0186-2) [5].

They make suggestions like:

* Life expectancy test sets
  * the discount rate for QALYs to zero 
  * all dis-utilities to zero 
  * disease-specific mortality rates to the all-cause mortality rates.  
* Quality-Adjusted Life Expectancy  
* Total undiscounted intervention costs 
* Changes in intervention cost   
* Cohort size
  * total remains constant
  * number of patients in each health state in all cycles >=0.
* Sample PSA input means 

Testing validity has been discussed in [3].

The collection of test are recorded in a document similar to [this example](https://github.com/StatisticsHealthEconomics/HTAinRmanifesto/blob/main/test_case_example/test_case_example.csv).

Then these are translated to actual tests in the target language, such as the `testthat` packages examples [here](https://github.com/StatisticsHealthEconomics/HTAinRmanifesto/blob/main/test_case_example/testthat_example.R).

For tests using random numbers the same seed must be used.

### References

[1]: Dasbach, E.J., Elbasha, E.H. Verification of Decision-Analytic Models for Health Economic Evaluations: An Overview. PharmacoEconomics 35, 673–683 (2017). https://doi.org/10.1007/s40273-017-0508-2

[2]: Alarid-Escudero, F., Krijkamp, E. M., Pechlivanoglou, P., Jalal, H., Kao, S. Y. Z., Yang, A., & Enns, E. A. (2019). A Need for Change! A Coding Framework for Improving Transparency in Decision Modeling. PharmacoEconomics, 37(11), 1329–1339. https://doi.org/10.1007/s40273-019-00837-x

[3]: McCabe, C., & Dixon, S. (2000). Testing the validity of cost-effectiveness models. PharmacoEconomics, 17(5), 501–513. https://doi.org/10.2165/00019053-200017050-00007

[4]: Husereau, D., Drummond, M., Petrou, S., Carswell, C., Moher, D., Greenberg, D., … Loder, E. (2013). Consolidated Health Economic Evaluation Reporting Standards (CHEERS) statement. European Journal of Health Economics, 14(3), 367–372. https://doi.org/10.1007/s10198-013-0471-6

[5] Tappenden, P., Chilcott, J.B. Avoiding and Identifying Errors and Other Threats to the Credibility of Health Economic Models. PharmacoEconomics 32, 967–979 (2014). https://doi.org/10.1007/s40273-014-0186-2

