# getters

#' @title Getter for QALYs
#' @param res A list of results returned by ce_markov.
#' @return A numeric vector of total QALYs by treatment.
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_qalys(res)
#' @export
get_qalys <- function(res) {
  res$total_QALYs
}

#' @title Getter for costs
#' @param res A list of results returned by ce_markov.
#' @return A numeric vector of total costs by treatment.
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_costs(res)
#' @export 
get_costs <- function(res) {
  res$total_costs
}

#' @title Getter for life expectancy (LE)
#' @param res A list of results returned by ce_markov.
#' @return A numeric vector of total life expectancy by treatment.
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_le(res)
#' @export
get_le <- function(res) {
  res$total_LE
}

#' @title Getter for ICER
#' @param res A list of results returned by ce_markov.
#' @return A numeric value representing the incremental cost-effectiveness ratio (ICER).
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_icer(res)
#' @export
get_icer <- function(res) {
  c_incr <- res$total_costs["with_drug"] - res$total_costs["without_drug"]
  q_incr <- res$total_QALYs["with_drug"] - res$total_QALYs["without_drug"]
  as.numeric(c_incr / q_incr)
}
